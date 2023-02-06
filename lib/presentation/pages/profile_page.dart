import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../../data/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final double _horizontalPadding = 0.0;

  int getLikes(List<Review> reviews) {
    int likes = 0;
    reviews.map((e) => likes += e.likesCount);
    return likes;
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProfileCubit>().loadProfile();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.status.runtimeType) {
              case LoadedStatus<User>:
                return IntrinsicHeight(
                  child: Column(
                    children: [
                      profileCard(context),
                      statsWidget(
                          countReview: state.userReviews.item!.length,
                          countLikes: getLikes(state.userReviews.item!)),
                      Expanded(child: reviewsListWidget(context)),
                      const SizedBox(height: 10),
                      Text('${state.userReviews.item!.length} запись',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                );
              case LoadingStatus<User>:
                return SizedBox(
                    height: deviceWidth,
                    child: const Center(child: CircularProgressIndicator()));
              default:
                print(state.userReviews.runtimeType);
                SizedBox(
                    height: deviceWidth,
                    child: const Center(child: CircularProgressIndicator()));
            }
            return SizedBox(
                height: deviceWidth,
                child: const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  Widget reviewsListWidget(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        switch (state.userReviews.runtimeType) {
          case LoadedStatus<List<Review>>:
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: state.userReviews.item!
                    .map((review) => ReviewWidget(review: review))
                    .toList(),
              ),
            );
          case LoadingStatus<List<Review>>:
            return const Center(child: CircularProgressIndicator());
          default:
            print(state.userReviews.runtimeType);
            const Center(child: CircularProgressIndicator());
        }
        return const Center(child: CircularProgressIndicator());
        // return reviewWidget(context, state.userReviews.first);
      },
    );
  }

  Padding statsWidget({required int countReview, required countLikes}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: 12,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                itemInStatsRow(title: 'Рецензий', value: countReview),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                itemInStatsRow(title: 'Лайков', value: countLikes),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                itemInStatsRow(title: 'Конфет', value: '29'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column itemInStatsRow({required String title, required dynamic value}) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }

  Widget profileCard(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/wallpaper.jpg')),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: profileWidget(context),
        ),
      ],
    );
  }

  Widget profileWidget(BuildContext mainContext) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        print('state: ${state.status.runtimeType}');
        switch (state.status.runtimeType) {
          case FailedStatus<User>:
            break;
          case LoadingStatus<User>:
            return const Center(child: CircularProgressIndicator());
          case LoadedStatus<User>:
            return Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 210,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 50.0,
                        left: _horizontalPadding,
                        right: _horizontalPadding,
                      ),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.status.item!.getFullName(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Почта: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(state.status.item!.email),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.status.item?.image == null
                          ? CircleAvatar(
                              minRadius: 2,
                              maxRadius: 60,
                              child: Text(
                                state.status.item!.getInitials(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 36),
                              ),
                            )
                          : CircleAvatar(
                              minRadius: 2,
                              maxRadius: 60,
                              backgroundImage:
                                  NetworkImage(state.status.item!.image!),
                            ),
                    ),
                  ),
                ),
              ],
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
        return const Text('asdasda');
      },
    );
  }
}
