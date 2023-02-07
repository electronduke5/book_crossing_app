import 'package:book_crossing_app/presentation/widgets/profile_image_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key, required this.review, this.horizontalPadding})
      : super(key: key);

  final Review review;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: 5),
      child: Material(
        child: InkWell(
          onDoubleTap: () {
            print('like! 19');
          },
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ProfileAvatarSmall(
                        user: review.user,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.user.getFullName(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(review.getDate(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  bookInfoReview(context, review.book),
                  const SizedBox(height: 15),
                  Text(
                    review.text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  //const Divider(indent: 10, endIndent: 10, thickness: 0.1),
                  RatingBarIndicator(
                    itemBuilder: (context, index) {
                      return Icon(Icons.star,
                          color: Theme.of(context).colorScheme.secondary);
                    },
                    itemSize: MediaQuery.of(context).size.width / 11,
                    itemCount: 10,
                    rating: review.bookRating.toDouble(),
                  ),
                  Text('Оценка: ${review.bookRating}/10'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          print('like! 60');
                        },
                        icon: const Icon(Icons.favorite_outline),
                        label: Text(review.likesCount.toString()),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Row bookInfoReview(BuildContext context, Book book) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Книга', style: Theme.of(context).textTheme.bodySmall),
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Автор', style: Theme.of(context).textTheme.bodySmall),
          Text(
            '${book.author.name} ${book.author.surname}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    ],
  );
}
