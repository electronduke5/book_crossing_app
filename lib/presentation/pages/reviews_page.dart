import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/profile_image_small.dart';

class ReviewsPage extends StatelessWidget {
  ReviewsPage({Key? key}) : super(key: key);

  List<Review> allReviews = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          AppBar(
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
                    delegate: CustomSearchDelegate(allReviews),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
            ],
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
                      return const Center(child: CircularProgressIndicator());
                    case FailedStatus<List<Review>>:
                      return Center(
                          child: Text(state.reviews.message ?? 'Failed'));
                    case LoadedStatus<List<Review>>:
                      allReviews = state.reviews.item!;
                      return ListView.builder(
                          //TODO: clipBehavior: Clip.none,
                          clipBehavior: Clip.antiAlias,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.reviews.item!.length,
                          itemBuilder: (context, index) {
                            return ReviewWidget(
                                review: state.reviews.item![index]);
                          });
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
