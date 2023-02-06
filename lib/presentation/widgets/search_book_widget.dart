import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_choices/search_choices.dart';

import '../../data/models/book.dart';
import '../cubits/book/book_cubit.dart';
import '../cubits/models_status.dart';
import '../cubits/review/review_cubit.dart';

class SearchBookField extends StatefulWidget {
  //SearchBookField({Key? key, required this.formKey}) : super(key: key);
  SearchBookField({Key? key}) : super(key: key);

  //List<DropdownMenuItem<Book>> bookItems;
  //GlobalKey<FormState> formKey;

  @override
  State<SearchBookField> createState() => _SearchBookFieldState();
}

class _SearchBookFieldState extends State<SearchBookField> {
  Book? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
      print(state.booksStatus.runtimeType);
      switch (state.booksStatus.runtimeType) {
        case LoadingStatus<List<Book>>:
          return const Center(child: CircularProgressIndicator());
        case FailedStatus:
          return Center(
              child: Text(state.booksStatus.message ??
                  'Ошибка add_review_page 29 стр'));
        case LoadedStatus<List<Book>>:
          List<Book> bookItems = state.booksStatus.item!;
          List<DropdownMenuItem<Book>> menuItems = bookItems
              .map((book) => DropdownMenuItem<Book>(
                    value: book,
                    child: Text(
                        '${book.title}  - ${book.author.name} ${book.author.surname}'),
                  ))
              .toList();
          return SearchChoices.single(
            validator: (value) {
              if (value == null) {
                return 'Это обязательное поле';
              }
            },
            items: menuItems,
            value: _selectedItem,
            hint: 'Книга',
            searchHint: 'Выберите книгу или добавьте новую',
            dialogBox: false,
            isExpanded: true,
            //doneButton: 'Готово',
            menuConstraints: BoxConstraints.tight(const Size.fromHeight(350)),
            closeButton: (Book? value, BuildContext closeContext,
                Function updateParent) {
              return (menuItems.length >= 100
                  ? "Close"
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/add-book')
                            .then((value) async {
                          if (value != null) {
                            menuItems.add(DropdownMenuItem<Book>(
                              value: value as Book,
                              child: Text(
                                  '${value.title}  - ${value.author.name} ${value.author.surname}'),
                            ));
                            if (menuItems.indexWhere(
                                    (element) => element.value == value) !=
                                -1) {
                              context.read<BookCubit>().loadBooks();
                              updateParent(value, true);
                            }
                          }
                        });
                      },
                      child: const Text("Добавить новую книгу"),
                    ));
            },
            disabledHint: (Function updateParent) {
              return (TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/add-book')
                      .then((value) async {
                    updateParent(value);
                  });
                },
                child: Text("No choice, click to add one"),
              ));
            },
            displayItem:
                (DropdownMenuItem item, selected, Function updateParent) {
              bool deleteRequest = false;
              return ListTile(
                title: item,
                onTap: () {
                  if (!deleteRequest) {
                    updateParent(item.value, true);
                  }
                },
                horizontalTitleGap: 0,
              );
            },
            autofocus: false,
            onChanged: (Book? value, Function? pop) {
              context.read<ReviewCubit>().bookChanged(value!);
              setState(() {
                if (value is! NotGiven) {
                  _selectedItem = value;
                }
                if (pop != null && value is! NotGiven && value != null) {
                  pop();
                }
              });
            },
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
