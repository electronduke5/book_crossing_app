import 'package:book_crossing_app/presentation/cubits/like/like_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/widgets/popup_icon_item.dart';
import 'package:book_crossing_app/presentation/widgets/profile_widgets/profile_image_small.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../data/models/book.dart';
import '../../../data/models/review.dart';
import '../../../data/utils/datetime_helpers.dart';
import '../../cubits/review/review_cubit.dart';

// ignore: must_be_immutable
class ReviewWidget extends StatelessWidget {
  ReviewWidget({
    Key? key,
    required this.review,
    this.horizontalPadding,
    this.isProfileReview = false,
  }) : super(key: key);

  Review review;
  final bool isProfileReview;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeCubit>(
      create: (context) => LikeCubit(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0, vertical: 5),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              child: BlocBuilder<LikeCubit, LikeState>(
                builder: (context, state) => InkWell(
                  onDoubleTap: () async {
                    review =
                        (await context.read<LikeCubit>().likeReview(review))!;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/profile-page',
                              arguments: review.user);
                        },
                        child: Row(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(DateTimeHelper.dateMonth(review.dateCreated),
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                            const Spacer(),
                            () {
                              if (isProfileReview) {
                                return PopupMenuButton(
                                    onSelected: (value) => _onSelected(
                                        context: context,
                                        review: review,
                                        value: value),
                                    icon: const Icon(Icons.more_horiz),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    itemBuilder: (context) {
                                      return [
                                        review.isArchived
                                            ? PopupIconMenuItem(
                                                title: 'Восстановить',
                                                icon: Icons.unarchive_outlined)
                                            : PopupIconMenuItem(
                                                title: 'Архивировать',
                                                icon: Icons.archive_outlined),
                                        PopupIconMenuItem(
                                            title: 'Удалить',
                                            icon: Icons.delete_outline,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error),
                                      ];
                                    });
                              } else {
                                return const SizedBox();
                              }
                            }()
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      bookInfoReview(context, review.book),
                      const SizedBox(height: 15),
                      Text(
                        review.text,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      RatingBarIndicator(
                        itemBuilder: (context, index) {
                          return Icon(Icons.star,
                              color: Theme.of(context).colorScheme.secondary);
                        },
                        itemSize: MediaQuery.of(context).size.width / 11,
                        itemCount: 10,
                        rating: review.bookRating.toDouble(),
                      ),
                      Text('Оценка книги: ${review.bookRating}/10'),
                      const SizedBox(height: 10),
                      BlocBuilder<LikeCubit, LikeState>(
                        builder: (context, state) {
                          return ElevatedButton.icon(
                            onPressed: () async {
                              review = (await context
                                  .read<LikeCubit>()
                                  .likeReview(review))!;
                            },
                            icon: Icon(review.likedUser
                                        ?.map((user) => user.id)
                                        .contains(AppModule.getProfileHolder()
                                            .user.id) ??
                                    false
                                ? Icons.favorite
                                : Icons.favorite_outline),
                            label: Text(
                              review.likesCount.toString(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Review?> _onSelected(
    {required BuildContext context,
    required Review review,
    required String value}) async {
  switch (value) {
    case 'Восстановить':
      await context.read<ReviewCubit>().unzipReview(review).then((value) => SnackBarInfo.show(
        context: context,
        message: 'Отзыв восстановлен',
        isSuccess: true,
      ));
      return review;

    case 'Архивировать':
      await context.read<ReviewCubit>().archiveReview(review)
        .then((value) => SnackBarInfo.show(
              context: context,
              message: 'Отзыв перемещен в архив',
              isSuccess: true,
            ));
      return review;

    case 'Удалить':
      await context
          .read<ReviewCubit>()
          .deleteReview(review)
          .then((value) => SnackBarInfo.show(
                context: context,
                message: 'Отзыв успешно удален',
                isSuccess: true,
              ));
      break;
  }
  return null;
}

Widget bookInfoReview(BuildContext context, Book book) {
  return Wrap(
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
