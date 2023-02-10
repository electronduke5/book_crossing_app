import 'package:book_crossing_app/presentation/widgets/review_widget.dart';
import 'package:flutter/material.dart';

import '../../data/models/review.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Review> reviews;

  @override
  String get searchFieldLabel => 'Поиск';

  CustomSearchDelegate(this.reviews);

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
    List<Review> matchQuery = [];
    for (var review in reviews) {
      if (review.title.contains(query) || review.text.contains(query)) {
        matchQuery.add(review);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ReviewWidget(review: matchQuery[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Review> matchQuery = [];
    for (var review in reviews) {
      if (review.title.contains(query) || review.text.contains(query)) {
        matchQuery.add(review);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ReviewWidget(review: matchQuery[index]);
      },
    );
  }
}
