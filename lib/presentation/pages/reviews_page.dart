import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/widgets/review_shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/popup_icon_item.dart';
import '../widgets/profile_image_small.dart';
import '../widgets/review_widget.dart';

class ReviewsPage extends StatelessWidget {
  ReviewsPage({Key? key}) : super(key: key);

  List<Review> allReviews = [];
  final _scrollController = ScrollController();
  final _height = 80.0;
  
  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          InkWell(
            onTap: () => _scrollToIndex(0),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: ProfileAvatarSmall(
                    maxRadius: 15, user: AppModule.getProfileHolder().user),
              ),
              title: const Text(
                'Главная',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(reviews: allReviews),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                PopupMenuButton<String>(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) async {
                    allReviews = await _onSelected(
                        context: context, allReviews: allReviews, value: value);
                  },
                  itemBuilder: (context) {
                    return [
                      PopupIconMenuItem(
                          title: 'Сначала новые', icon: Icons.date_range),
                      PopupIconMenuItem(
                          title: 'Сначала старые', icon: Icons.date_range),
                      PopupIconMenuItem(
                          title: 'По кол-ву лайков',
                          icon: Icons.favorite_outline),
                      PopupIconMenuItem(
                          title: 'По возрастанию оценки',
                          icon: Icons.arrow_upward),
                      PopupIconMenuItem(
                          title: 'По убыванию оценки',
                          icon: Icons.arrow_downward),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context
                    .read<ReviewCubit>()
                    .loadReviews()
                    .then((value) => allReviews = value!);
              },
              child: BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  print(state.reviews.runtimeType);
                  switch (state.reviews.runtimeType) {
                    case (LoadingStatus<List<Review>>):
                      return ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              const ReviewShimmerCard());
                    case FailedStatus<List<Review>>:
                      return Center(
                          child: Text(state.reviews.message ?? 'Failed'));
                    case LoadedStatus<List<Review>>:
                      allReviews.isEmpty
                          ? allReviews = state.reviews.item!
                          : () {};
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                controller: _scrollController,
                                clipBehavior: Clip.antiAlias,
                                physics: const BouncingScrollPhysics(),
                                itemCount: allReviews.length,
                                itemBuilder: (context, index) {
                                  return ReviewWidget(
                                      review: allReviews[index]);
                                }),
                          ),
                          const SizedBox(height: 65),
                        ],
                      );
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Review>> _onSelected({
  required BuildContext context,
  required List<Review> allReviews,
  required String value,
}) async {
  switch (value) {
    case 'Сначала новые':
      await context
          .read<ReviewCubit>()
          .loadReviews()
          .then((value) => allReviews = value!);
      allReviews.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      break;

    case 'Сначала старые':
      await context
          .read<ReviewCubit>()
          .loadReviews()
          .then((value) => allReviews = value!);
      allReviews.sort((b, a) => b.dateCreated.compareTo(a.dateCreated));
      break;
    case 'По кол-ву лайков':
      await context
          .read<ReviewCubit>()
          .loadReviews()
          .then((value) => allReviews = value!);
      allReviews.sort((a, b) => b.likesCount.compareTo(a.likesCount));
      break;
    case 'По возрастанию оценки':
      await context
          .read<ReviewCubit>()
          .loadReviews()
          .then((value) => allReviews = value!);
      allReviews.sort((a, b) => a.bookRating.compareTo(b.bookRating));
      break;
    case 'По убыванию оценки':
      await context
          .read<ReviewCubit>()
          .loadReviews()
          .then((value) => allReviews = value!);
      allReviews.sort((b, a) => a.bookRating.compareTo(b.bookRating));
      break;
  }
  return allReviews;
}
