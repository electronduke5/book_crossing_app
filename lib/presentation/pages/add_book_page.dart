import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/genre/genre_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/author.dart';
import '../../data/models/genre.dart';
import '../cubits/author/author_cubit.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_author_widget.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthorCubit, AuthorState>(
            // bloc: authorCubit,
            builder: (context, state) {
              switch (state.getAuthorsState.runtimeType) {
                case LoadingStatus<List<Author>>:
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: LoadingWidget());
                case FailedStatus:
                  return Center(
                      child: Text(state.getAuthorsState.message ??
                          'Ошибка add_book_page 26'));
                case LoadedStatus<List<Author>>:
                  List<Author> authorItems = state.getAuthorsState.item!;
                  List<DropdownMenuItem<Author>> menuItemsAuthor = authorItems
                      .map((author) => DropdownMenuItem<Author>(
                            value: author,
                            child: Text(author.getInitials()),
                          ))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              'Для начала нужно добавить автора новой книги:'),
                          const SizedBox(height: 10),
                          SearchAuthorField(
                              authorItems: menuItemsAuthor,
                              bookCubit: context.read<BookCubit>()),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) =>
                                context.read<BookCubit>().titleChanged(value),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              labelText: 'Название книги',
                              prefixIcon: const Icon(Icons.book_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Война и мир',
                            ),
                          ),
                          const SizedBox(height: 10),
                          genresDropdown(context),
                          TextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await context
                                    .read<BookCubit>()
                                    .addBook()
                                    .then((value) {
                                  if (value != null) {
                                    Navigator.pop(context, value);
                                  }
                                });
                              }
                            },
                            child: const Text("Далее"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            child: const Text("Назад"),
                          ),
                        ],
                      ),
                    ),
                  );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget genresDropdown(BuildContext context) {
    return BlocBuilder<GenreCubit, GenreState>(
      builder: (context, state) {
        print('getGenres state: ${state.getGenresStatus.runtimeType}');
        switch (state.getGenresStatus.runtimeType) {
          case LoadingStatus<List<Genre>>:
            return DropdownButtonFormField<String>(
              items: [],
              onChanged: (Object? value) {},
              icon: const Icon(Icons.category_outlined),
              hint: const Text('Жанр'),
            );
          case FailedStatus:
            return Center(
                child: Text(state.getGenresStatus.message ??
                    'Ошибка при получении жанров'));
          case LoadedStatus<List<Genre>>:
            List<Genre> genreItems = state.getGenresStatus.item!;

            Genre? selectedItem;
            late List<DropdownMenuItem<Genre>> menuItems = genreItems
                .map((genre) => DropdownMenuItem<Genre>(
                      value: genre,
                      child: Text(genre.genreName),
                    ))
                .toList();

            return DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'Это обязательное поле';
                }
                return null;
              },
              value: selectedItem,
              icon: const Icon(Icons.category_outlined),
              hint: const Text('Жанр'),
              items: menuItems,
              onChanged: (Genre? genre) {
                selectedItem = genre;
                context.read<BookCubit>().genreChanged(genre!);
              },
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
