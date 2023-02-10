import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/widgets/popup_icon_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../di/app_module.dart';
import '../widgets/book_widget.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/profile_image_small.dart';

class BooksPage extends StatelessWidget {
  BooksPage({Key? key}) : super(key: key);

  Book? book;
  List<Book> allBooks = [];
  final _scrollController = ScrollController();
  final _height = 80.0;

  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _scrollToIndex(0);
            },
            child: AppBar(
              leading: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: ProfileAvatarSmall(
                    maxRadius: 15, user: AppModule.getProfileHolder().user),
              ),
              title: const Text(
                'Книги',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(books: allBooks),
                      );
                    },
                    icon: const Icon(Icons.search)),
                PopupMenuButton<String>(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  onSelected: (value) async {
                    allBooks = await _onSelected(
                        context: context, value: value, books: allBooks);
                  },
                  icon: const Icon(Icons.filter_list),
                  itemBuilder: (context) {
                    return [
                      PopupIconMenuItem(
                        title: 'По количеству ревью',
                        icon: Icons.sort,
                      ),
                      PopupIconMenuItem(
                        title: 'По возрастанию рейтинга',
                        icon: Icons.arrow_upward,
                      ),
                      PopupIconMenuItem(
                        title: 'По убыванию рейтинга',
                        icon: Icons.arrow_downward,
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: buildBooksList(context),
          ),
        ],
      ),
    );
  }

  Widget buildBooksList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context
            .read<BookCubit>()
            .loadBooks()
            .then((value) => allBooks = value!);
      },
      child: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          switch (state.booksStatus.runtimeType) {
            case LoadingStatus<List<Book>>:
              return const Center(child: CircularProgressIndicator());
            case LoadedStatus<List<Book>>:
              if (state.booksStatus.item == null) {
                return const Center(child: CircularProgressIndicator());
              }
              allBooks.isEmpty ? allBooks = state.booksStatus.item! : () {};
              return ListView.builder(
                controller: _scrollController,
                clipBehavior: Clip.antiAlias,
                physics: const BouncingScrollPhysics(),
                itemCount: allBooks.length,
                itemBuilder: (context, index) {
                  return BookWidget(book: allBooks[index]);
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Book>> _onSelected(
      {required BuildContext context,
      required List<Book> books,
      required String value}) async {
    switch (value) {
      case 'По количеству ревью':
        await context
            .read<BookCubit>()
            .loadBooks()
            .then((value) => allBooks = value!);
        books.sort((b, a) => a.reviewsCount.compareTo(b.reviewsCount));
        break;
      case 'По возрастанию рейтинга':
        await context
            .read<BookCubit>()
            .loadBooks()
            .then((value) => allBooks = value!);
        books.sort((a, b) => a.rating!.compareTo(b.rating!));
        break;
      case 'По убыванию рейтинга':
        await context
            .read<BookCubit>()
            .loadBooks()
            .then((value) => allBooks = value!);
        books.sort((b, a) => a.rating!.compareTo(b.rating!));
        break;
    }
    return books;
  }
}
