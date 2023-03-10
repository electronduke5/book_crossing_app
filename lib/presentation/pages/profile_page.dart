import 'package:book_crossing_app/data/utils/image_picker.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/photo_view_page.dart';
import 'package:book_crossing_app/presentation/widgets/popup_icon_item.dart';
import 'package:book_crossing_app/presentation/widgets/profile_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/review_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/review_widget.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/review.dart';
import '../../data/models/user.dart';
import '../cubits/theme/theme_cubit.dart';
import '../widgets/profile_category_review.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final double _horizontalPadding = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  int getLikes(List<Review> reviews) {
    int likes = 0;
    for (var element in reviews) {
      likes += element.likesCount;
    }
    return likes;
  }

  List<Review> reviews = [];
  User? user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User?;
    if (user != null) {
      context.read<ProfileCubit>().loadProfile(user: user);
    }

    final double deviceHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProfileCubit>().loadProfile(user: user);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.status.runtimeType) {
              case LoadedStatus<User>:
                reviews = state.userReviews.item!;
                return IntrinsicHeight(
                  child: Column(
                    children: [
                      profileCard(context),
                      statsWidget(
                          countReview: state.userReviews.item!.length,
                          countLikes: getLikes(state.userReviews.item!)),
                          () {
                        if (user == null) {
                          return ProfileCategoryReviewWidget(
                            onFilterChanged: (value) => reviews = value,
                          );
                        }
                        return const SizedBox();
                      }(),
                      Expanded(
                        child: BlocBuilder<ReviewCubit, ReviewState>(
                          builder: (context, state) {
                            switch (state.reviews.runtimeType) {
                              case LoadedStatus<List<Review>>:
                                return reviewsListWidget(context, reviews);
                              case LoadingStatus<List<Review>>:
                                return SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                    itemCount: 2,
                                    itemBuilder: (context, state) =>
                                        const ReviewShimmerCard(),
                                  ),
                                );
                              default:
                                return const Center(
                                    child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<ReviewCubit, ReviewState>(
                        builder: (context, state) {
                          if (state.reviews.runtimeType ==
                              LoadedStatus<List<Review>>) {
                            return Text('${reviews.length} ??????????????',
                                style: Theme.of(context).textTheme.titleSmall);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 65),
                    ],
                  ),
                );
              case LoadingStatus<User>:
                return SizedBox(
                    height: deviceHeight, child: const ProfileShimmerCard());
              default:
                print(state.status.runtimeType);
                return SizedBox(
                    height: deviceHeight,
                    child: const Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }

  Widget reviewsListWidget(BuildContext context, List<Review> reviews) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: reviews
            .map((review) =>
                ReviewWidget(review: review, isProfileReview: user == null))
            .toList(),
      ),
    );
  }

  Widget statsWidget({required int countReview, required countLikes}) {
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
                itemInStatsRow(title: '????????????????', value: countReview),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                itemInStatsRow(title: '????????????', value: countLikes),
                // const VerticalDivider(
                //   indent: 10,
                //   endIndent: 10,
                // ),
                // itemInStatsRow(title: '????????????', value: '29'),
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
            () {
          if (user == null) {
            return popupProfileMenu(context);
          }
          return const SizedBox();
        }(),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: profileWidget(context),
        ),
      ],
    );
  }

  Positioned popupProfileMenu(BuildContext context) {
    return Positioned(
      right: 5,
      top: 5,
      child: PopupMenuButton(
        icon: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Material(
              color: Theme.of(context).cardColor.withOpacity(0.7),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.more_horiz, size: 28),
              )),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (context) => [
          PopupIconMenuItem(
              title: '???????????????????????? ??????????????', icon: Icons.edit_outlined),
          PopupIconMenuItem(title: '??????????', icon: Icons.exit_to_app_outlined),
          PopupIconMenuItem(
            title: '?????????????? ????????',
            icon: context.read<ThemeCubit>().getCurrentTheme == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case '???????????????????????? ??????????????':
              buildEditProfileWidget(context);
              break;
            case '??????????':
              AppModule.getPreferencesRepository().removeSavedProfile();
              Navigator.of(context).pushNamed('/sign-in');
              break;
            case '?????????????? ????????':
              context.read<ThemeCubit>().switchTheme();
              break;
          }
        },
      ),
    );
  }

  PersistentBottomSheetController<dynamic> buildEditProfileWidget(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: SizedBox(
          height: 300,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) => Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                          const Text(
                            '???????????????????????????? ??????????????',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '?????????????? ??????';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: '??????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: surnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '?????????????? ??????????????';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: '??????????????',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final surname = surnameController.value.text;
                          final name = nameController.value.text;
                          surnameController.clear();
                          nameController.clear();
                          SnackBarInfo.show(
                              context: context,
                              message: '???????????? ??????????????????',
                              isSuccess: true);
                          Navigator.of(context).pop();
                          await context
                              .read<ProfileCubit>()
                              .updateProfile(surname: surname, name: name);
                        }
                              },
                              child: const Text('??????????????????')),
                        ],
                      ),
                    ),
              ),
            ),
          ),
    );
  }

  Widget profileWidget(BuildContext mainContext) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
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
                                  '??????????: ',
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
                    child: () {
                      if (state.status.item!.image == null && user != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            minRadius: 2,
                            maxRadius: 60,
                            child: Text(
                              state.status.item!.getInitials(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 36),
                            ),
                          ),
                        );
                      }
                      return PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        offset: const Offset(-30, 120),
                        itemBuilder: (context) =>
                            user == null ? buttonsProfile : buttonsGuest,
                        onSelected: (value) async {
                          switch (value) {
                            case '?????????????? ????????':
                              if (state.status.item!.image == null) {
                                SnackBarInfo.showTop(
                                    context: context,
                                    message: '???????????????????? ?????? ??????',
                                    isSuccess: false);
                                break;
                              }
                              PhotoViewDialog(state.status.item!)
                                  .dialogBuilder(context);
                              break;
                            case '???????????????? ????????':
                              await ImageHelper()
                                  .getFromGallery()
                                  .then((value) {
                                if (value != null) {
                                  context
                                      .read<ProfileCubit>()
                                      .updateProfile(image: value);
                                }
                                return null;
                              });
                              break;
                            case '?????????????? ????????':
                              if (state.status.item!.image == null) {
                                SnackBarInfo.showTop(
                                    context: context,
                                    message: '???????????????????? ?????? ??????',
                                    isSuccess: false);
                                break;
                              }
                              await context
                                  .read<ProfileCubit>()
                                  .removeProfileImage();
                              break;
                          }
                        },
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
                      );
                    }(),
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

  List<PopupIconMenuItem> buttonsProfile = [
    PopupIconMenuItem(
        title: '?????????????? ????????', icon: Icons.account_circle_outlined),
    PopupIconMenuItem(title: '???????????????? ????????', icon: Icons.edit_outlined),
    PopupIconMenuItem(
        color: Colors.red, title: '?????????????? ????????', icon: Icons.delete_outlined),
  ];
  List<PopupIconMenuItem> buttonsGuest = [
    PopupIconMenuItem(
        title: '?????????????? ????????', icon: Icons.account_circle_outlined),
  ];
}
