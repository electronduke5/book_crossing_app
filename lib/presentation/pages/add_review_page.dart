import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/review_widgets/review_title_widget.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';
import '../di/app_module.dart';
import '../widgets/profile_widgets/profile_image_small.dart';
import '../widgets/review_widgets/review_text.dart';

class AddReviewPage extends StatelessWidget {
  AddReviewPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Book? book = ModalRoute.of(context)!.settings.arguments as Book?;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) async {
            switch (state.createReviewStatus.runtimeType) {
              case LoadedStatus<Review>:
                SnackBarInfo.show(
                    context: context, message: 'Рецензия создана!', isSuccess: true);
                Navigator.of(context).pushReplacementNamed('/main');
                break;
              case FailedStatus<Review>:
                SnackBarInfo.show(
                    context: context,
                    message: 'Ошибка при создании рецензии!',
                    isSuccess: false);
                break;
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: ProfileAvatarSmall(
                        maxRadius: 15, user: AppModule.getProfileHolder().user),
                  ),
                  title: const Text(
                    'Добавление рецензии',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 13.0, right: 13.0, top: 5, bottom: 7),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const ReviewTitle(),
                          const SizedBox(height: 10),
                          const ReviewText(),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book!.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      Text(book.author.getInitials(),
                                          style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${book.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const Icon(Icons.star),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Как вы оцените эту книгу?',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          RatingBar.builder(
                            minRating: 1,
                            maxRating: 10,
                            direction: Axis.horizontal,
                            itemCount: 10,
                            //allowHalfRating: true,
                            glow: false,
                            updateOnDrag: true,
                            itemSize: MediaQuery.of(context).size.width / 11,
                            itemBuilder: (context, index) {
                              return Icon(Icons.star,
                                  color: Theme.of(context).colorScheme.secondary);
                            },
                            onRatingUpdate: (double value) =>
                                context.read<ReviewCubit>().ratingChanged(value.toInt()),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<ReviewCubit, ReviewState>(
                            builder: (context, state) {
                              return Text('${state.rating.toString()}/10');
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              context.read<ReviewCubit>().bookChanged(book);
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<ReviewCubit>().createReview();
                              }
                            },
                            child: const Text('Добавить'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 65),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
