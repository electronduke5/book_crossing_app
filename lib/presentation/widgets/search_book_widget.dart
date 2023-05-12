import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_choices/search_choices.dart';

import '../../data/models/book.dart';
import '../cubits/book/book_cubit.dart';
import '../cubits/models_status.dart';

class SearchBookField extends StatefulWidget {
  SearchBookField({Key? key, this.userBooks, required this.onChanged}) : super(key: key);

  List<Book>? userBooks;

  final ValueChanged<Book?> onChanged;

  @override
  State<SearchBookField> createState() => _SearchBookFieldState();
}

class _SearchBookFieldState extends State<SearchBookField> {
  Book? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
      () {
        print(widget.userBooks);
        if (widget.userBooks != null) {
          List<Book> bookItems = widget.userBooks!;
          List<DropdownMenuItem<Book>> menuItems = bookItems
              .map((book) => DropdownMenuItem<Book>(
                    value: book,
                    child: Text(
                        '${book.title}  - ${book.author.name} ${book.author.surname}'),
                  ))
              .toList();
          return buildSearchBookWidget(menuItems, context);
        }
      }();
      print(state.booksStatus.runtimeType);
      switch (state.booksStatus.runtimeType) {
        case LoadingStatus<List<Book>>:
          return const Center(child: CircularProgressIndicator());
        case FailedStatus:
          return Center(
              child: Text(state.booksStatus.message ?? 'Ошибка add_review_page 29 стр'));
        case LoadedStatus<List<Book>>:
          List<Book> bookItems = state.booksStatus.item!;
          List<DropdownMenuItem<Book>> menuItems = bookItems
              .map((book) => DropdownMenuItem<Book>(
                    value: book,
                    child: Text(
                        '${book.title}  - ${book.author.name} ${book.author.surname}'),
                  ))
              .toList();
          return buildSearchBookWidget(menuItems, context);
        default:
          print(widget.userBooks);
          if (widget.userBooks != null) {
            List<Book> bookItems = widget.userBooks!;
            List<DropdownMenuItem<Book>> menuItems = bookItems
                .map((book) => DropdownMenuItem<Book>(
              value: book,
                      child: Text(
                          '${book.id}) ${book.title}  - ${book.author.name} ${book.author.surname}'),
                    ))
                .toList();
            return buildSearchBookWidget(menuItems, context);
          }
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  SearchChoices<Book> buildSearchBookWidget(
      List<DropdownMenuItem<Book>> menuItems, BuildContext context) {
    return SearchChoices.single(
      validator: (value) {
        if (value == null) {
          return 'Это обязательное поле';
        }
      },
      items: menuItems,
      value: _selectedItem,
      hint: 'Книга',
      searchHint: 'Выберите книгу',
      dialogBox: false,
      isExpanded: true,
      doneButton: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Назад"),
      ),
      menuConstraints: BoxConstraints.tight(const Size.fromHeight(350)),
      closeButton: (Book? value, BuildContext closeContext, Function updateParent) {
        return (menuItems.length >= 100
            ? "Закрыть"
            : TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/add-book').then((value) async {
                    if (value != null) {
                      menuItems.add(DropdownMenuItem<Book>(
                        value: value as Book,
                        child: Text(
                            '${value.title}  - ${value.author.name} ${value.author.surname}'),
                      ));
                      if (menuItems.indexWhere((element) => element.value == value) !=
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
            Navigator.of(context).pushNamed('/add-book').then((value) async {
              updateParent(value);
            });
          },
          child: const Text("No choice, click to add one"),
        ));
      },
      displayItem: (DropdownMenuItem item, selected, Function updateParent) {
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
        //context.read<ReviewCubit>().bookChanged(value!);
        setState(() {
          if (value is! NotGiven) {
            _selectedItem = value;
            widget.onChanged(value);
          }
          if (pop != null && value is! NotGiven && value != null) {
            pop();
          }
        });
      },
    );
  }
}
