import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/review_title_widget.dart';
import 'package:book_crossing_app/presentation/widgets/search_book_widget.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/models/review.dart';
import '../widgets/review_text.dart';

class AddReviewPage extends StatelessWidget {
  AddReviewPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        switch (state.createReviewStatus.runtimeType) {
          case LoadedStatus<Review>:
            SnackBarInfo.show(
                context: context,
                message: 'Рецензия создана!',
                isSuccess: true);
            break;
          case FailedStatus:
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
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                  top: Radius.circular(0),
                ),
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 13.0, right: 13.0, top: 5, bottom: 7),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Добавление рецензии',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ReviewTitle(),
                      const SizedBox(height: 10),
                      const ReviewText(),
                      const SizedBox(height: 10),
                      const Text(
                        'Теперь выберите книгу, на которую хотите написать рецензию:',
                        style: TextStyle(fontSize: 18),
                      ),
                      //SearchBookField(formKey: formKey),
                      SearchBookField(),
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
                        onRatingUpdate: (double value) => context
                            .read<ReviewCubit>()
                            .ratingChanged(value.toInt()),
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
                          if (formKey.currentState?.validate() ?? false) {
                            await context.read<ReviewCubit>().createReview();
                          }
                        },
                        child: const Text('Добавить'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
