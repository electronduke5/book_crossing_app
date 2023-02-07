import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../di/app_module.dart';
import '../widgets/book_widget.dart';
import '../widgets/profile_image_small.dart';

class BooksPage extends StatelessWidget {
  BooksPage({Key? key}) : super(key: key);

  Book? book;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: ProfileAvatarSmall(
                  maxRadius: 15, user: AppModule.getProfileHolder().user),
            ),
            title: const Text(
              'Книги',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
            ],
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
        await context.read<BookCubit>().loadBooks();
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
              return ListView.builder(
                clipBehavior: Clip.antiAlias,
                physics: const BouncingScrollPhysics(),
                itemCount: state.booksStatus.item?.length,
                itemBuilder: (context, index) {
                  return BookWidget(book: state.booksStatus.item![index]);
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
