import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';

class AddReviewPage extends StatelessWidget {
  AddReviewPage({Key? key, required this.bookItems}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            child: Form(
              child: Column(
                children: [
                  const Text('Доабвление рецензии:'),
                  const Text(
                      'Выберите книгу, на которую хотите написать рецензию'),
                  booksDropdown(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Book> bookItems;

  Book? _selectedItem;
  late List<DropdownMenuItem<Book>> menuItems = bookItems
      .map((book) => DropdownMenuItem<Book>(
            value: book,
            child: Text(
                '${book.title}  - ${book.author.name} ${book.author.surname}'),
          ))
      .toList();

  Widget booksDropdown(BuildContext context) {
    return BlocListener<BookCubit, BookState>(
      listener: (context, state) {
        if (state.booksStatus is LoadedStatus<List<Book>>) {
          formKey.currentState!.reset();
          _selectedItem = null;
        }
      },
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          return DropdownButtonFormField(
            validator: (value) {
              if (value == null) {
                return 'Это обязательное поле';
              }
            },
            value: _selectedItem,
            icon: const Icon(Icons.book_outlined),
            hint: const Text('Книга'),
            items: menuItems,
            onChanged: (Book? book) {
              _selectedItem = book;
              context.read<ReviewCubit>().bookChanged(book!);
            },
          );
        },
      ),
    );
  }
}
