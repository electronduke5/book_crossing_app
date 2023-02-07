import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';
import '../cubits/models_status.dart';
import '../di/app_module.dart';
import '../widgets/profile_image_small.dart';
import '../widgets/review_widget.dart';

class BookReviewPage extends StatelessWidget {
  BookReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Book? book = ModalRoute.of(context)!.settings.arguments as Book?;
    context.read<ReviewCubit>().loadReviews(filter: 'book', value: book?.id);
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              AppBar(
                leading: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: ProfileAvatarSmall(
                      maxRadius: 15, user: AppModule.getProfileHolder().user),
                ),
                title: Text(
                  '${book?.title} - ${book?.author.getInitials()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    print(state.reviews.runtimeType);
                    switch (state.reviews.runtimeType) {
                      case (LoadingStatus<List<Review>>):
                        return const Center(child: CircularProgressIndicator());
                      case FailedStatus<List<Review>>:
                        return Center(
                            child: Text(state.reviews.message ?? 'Failed'));
                      case LoadedStatus<List<Review>>:
                        return state.reviews.item!.isEmpty
                            ? buildEmptyReviewCard()
                            : ListView.builder(
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
    );
  }

  Widget buildEmptyReviewCard() {
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
                  onPressed: () {},
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
}
