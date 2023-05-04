import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../data/models/book.dart';

class BookWidgetSmall extends StatelessWidget {
  const BookWidgetSmall({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/book-review', arguments: book);
        },
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(book.author.getInitials(),
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                () {
                  if (book.image == null) {
                    return Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.primaries[
                                        Random().nextInt(Colors.primaries.length)],
                                    Colors.primaries[
                                        Random().nextInt(Colors.primaries.length)],
                                  ],
                                )),
                            height: 150,
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  book.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(book.author.getInitials(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 14)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: Image.network(book.image!),
                  );
                }(),
                const SizedBox(height: 15),
                Text(
                  book.description ?? "Описание пустое",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 10),
                //const Divider(indent: 10, endIndent: 10, thickness: 0.1),
                () {
                  if (book.rating != 0.0) {
                    return RatingBarIndicator(
                      itemBuilder: (context, index) {
                        return Icon(Icons.star,
                            color: Theme.of(context).colorScheme.secondary);
                      },
                      itemSize: MediaQuery.of(context).size.width / 22,
                      itemCount: 10,
                      rating: book.rating ?? 0.0,
                    );
                  }
                  return const SizedBox();
                }(),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star_outline),
                    Text(
                      book.rating != 0.0 ? '${book.rating}/10' : 'Отзывов ещё нет',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.library_books_outlined),
                    Text(
                      '${book.reviewsCount} ревью',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
