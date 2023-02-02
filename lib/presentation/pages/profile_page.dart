import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
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
    return SingleChildScrollView(
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
            case LoadingStatus:
              return const Center(child: CircularProgressIndicator());
            default:
              print(state.userReviews.runtimeType);
              const Center(child: CircularProgressIndicator());
          }
          return Text('Че то не так в profile_page.dart');
        },
      ),
    );
  }

  Widget reviewsListWidget(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        switch (state.userReviews.runtimeType) {
          case LoadedStatus<List<Review>>:
            return Column(
              children: state.userReviews.item!
                  .map((e) => reviewWidget(context, e))
                  .toList(),
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

  Widget reviewWidget(BuildContext context, Review review) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: 5),
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
                    review.user.image == null
                        ? CircleAvatar(
                            minRadius: 2,
                            maxRadius: 20,
                            child: Text(
                              review.user.getInitials(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 12),
                            ),
                          )
                        : CircleAvatar(
                            minRadius: 2,
                            maxRadius: 20,
                            backgroundImage: NetworkImage(review.user.image!),
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
    );
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
            print(state.status.message!);
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
        return Text('asdasda');
      },
    );
  }
}
