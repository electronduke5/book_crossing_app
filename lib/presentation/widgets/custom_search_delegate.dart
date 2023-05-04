import 'package:book_crossing_app/presentation/widgets/book_widgets/book_widget.dart';
import 'package:book_crossing_app/presentation/widgets/review_widgets/review_widget.dart';
import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Review>? reviews;
  final List<Book>? books;

  @override
  String get searchFieldLabel => 'Поиск';

  CustomSearchDelegate({this.reviews, this.books});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (reviews != null) {
      List<Review> matchQuery = [];
      for (var review in reviews!) {
        if (review.title.toLowerCase().contains(query.toLowerCase()) ||
            review.text.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(review);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ReviewWidget(review: matchQuery[index]);
        },
      );
    } else if (books != null) {
      List<Book> matchQuery = [];
      for (var book in books!) {
        if (book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author
                .getFullName()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add(book);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return BookWidget(book: matchQuery[index]);
        },
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (reviews != null) {
      List<Review> matchQuery = [];
      for (var review in reviews!) {
        if (review.title.toLowerCase().contains(query.toLowerCase()) ||
            review.text.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(review);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return ReviewWidget(review: matchQuery[index]);
        },
      );
    } else if (books != null) {
      List<Book> matchQuery = [];
      for (var book in books!) {
        if (book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author
                .getFullName()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          matchQuery.add(book);
        }
      }
      return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return BookWidget(book: matchQuery[index]);
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
