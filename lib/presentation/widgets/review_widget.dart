import 'package:book_crossing_app/presentation/cubits/like/like_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/widgets/profile_image_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({Key? key, required this.review, this.horizontalPadding})
      : super(key: key);

  Review review;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeCubit>(
      create: (context) => LikeCubit(),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: 5),
        child: Material(
          child: InkWell(
            onDoubleTap: () async {
              print('like! 19');
              review = (await context.read<LikeCubit>().likeBook(review))!;
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
                    BlocBuilder<LikeCubit, LikeState>(builder: (context, state) {
                      switch (state.likeStatus.runtimeType) {
                        case LoadingStatus:
                          return const Center(child: CircularProgressIndicator());
                        case LoadedStatus<Review>:
                          return ElevatedButton.icon(
                            onPressed: () async {
                              review = (await context
                                  .read<LikeCubit>()
                                  .likeBook(review))!;
                            },
                            icon: Icon(review.likedUser?.contains(
                                        AppModule.getProfileHolder().user) ??
                                    false
                                ? Icons.favorite
                                : Icons.favorite_outline),
                            label: Text(review.likesCount.toString()),
                          );
                        default:
                          return ElevatedButton.icon(
                            onPressed: () async {
                              await context.read<LikeCubit>().likeBook(review);
                            },
                            icon: Icon(review.likedUser?.contains(
                                        AppModule.getProfileHolder().user) ??
                                    false
                                ? Icons.favorite
                                : Icons.favorite_outline),
                            label: Text(
                              review.likesCount.toString(),
                            ),
                          );
                      }
                    }),
                  ],
                ),
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
