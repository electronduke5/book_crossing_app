import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/review_widgets/review_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';
import '../cubits/models_status.dart';
import '../di/app_module.dart';
import '../widgets/profile_widgets/profile_image_small.dart';
import '../widgets/review_widgets/review_text.dart';
import '../widgets/review_widgets/review_title_widget.dart';
import '../widgets/review_widgets/review_widget.dart';

class BookReviewPage extends StatelessWidget {
  BookReviewPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _scrollController = ScrollController();
  final _height = 80.0;

  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    Book? book = ModalRoute.of(context)!.settings.arguments as Book?;
    context.read<ReviewCubit>().loadReviews(filter: 'book', value: book?.id);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<ReviewCubit, ReviewState>(
          listener: (context, state) async {
            switch (state.createReviewStatus.runtimeType) {
              case LoadedStatus<Review>:
                SnackBarInfo.show(
                    context: context,
                    message: 'Рецензия создана!',
                    isSuccess: true);
                await context
                    .read<ReviewCubit>()
                    .loadReviews(filter: 'book', value: book?.id);
                break;
            }
          },
          child: Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => _scrollToIndex(0),
                    child: AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0),
                        child: ProfileAvatarSmall(
                            maxRadius: 15,
                            user: AppModule.getProfileHolder().user),
                      ),
                      title: Text(
                        '${book?.title} - ${book?.author.getInitials()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: BlocBuilder<ReviewCubit, ReviewState>(
                      builder: (context, state) {
                        print(state.reviews.runtimeType);
                        switch (state.reviews.runtimeType) {
                          case (LoadingStatus<List<Review>>):
                            return ListView.builder(
                              itemCount: book!.reviewsCount > 3
                                  ? 3
                                  : book.reviewsCount,
                              itemBuilder: (context, index) =>
                                  const ReviewShimmerCard(),
                            );
                          case FailedStatus<List<Review>>:
                            return Center(
                                child: Text(state.reviews.message ?? 'Failed'));
                          case LoadedStatus<List<Review>>:
                            return state.reviews.item!.isEmpty
                                ? buildEmptyReviewCard(context, book!)
                                : ListView.builder(
                              controller: _scrollController,
                                    //TODO: clipBehavior: Clip.none,
                                    clipBehavior: Clip.antiAlias,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.reviews.item!.length,
                                    itemBuilder: (context, index) {
                                      return ReviewWidget(
                                          review: state.reviews.item![index]);
                                    },
                                  );
                          default:
                            return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmptyReviewCard(BuildContext context, Book book) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Рецензий на данную книгу еще нет.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                Lottie.asset(
                  alignment: Alignment.topCenter,
                  'assets/lottie/space.json',
                ),
                const SizedBox(height: 15),
                const Text(
                  'Оставь отзыв на эту книгу первым!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) =>
                            buildBottomSheetAddReview(context, book));
                  },
                  child: const Text('Добавить рецензию'),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget buildBottomSheetAddReview(BuildContext context, Book book) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
          width: double.infinity,
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Оставить рецензию',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const ReviewTitle(),
                    const SizedBox(height: 10),
                    const ReviewText(),
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
                    ElevatedButton(
                      onPressed: () async {
                        context.read<ReviewCubit>().bookChanged(book);
                        if (formKey.currentState?.validate() ?? false) {
                          await context
                              .read<ReviewCubit>()
                              .createReview()
                              .then((value) => Navigator.of(context).pop());
                        }
                      },
                      child: const Text('Оставить'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
