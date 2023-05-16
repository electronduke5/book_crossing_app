import 'package:book_crossing_app/data/utils/image_picker.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/photo_view_page.dart';
import 'package:book_crossing_app/presentation/widgets/popup_icon_item.dart';
import 'package:book_crossing_app/presentation/widgets/profile_widgets/profile_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/review_widgets/review_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/review_widgets/review_widget.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/models/book.dart';
import '../../data/models/review.dart';
import '../../data/models/user.dart';
import '../cubits/theme/theme_cubit.dart';
import '../widgets/profile_widgets/profile_category_review.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final double _horizontalPadding = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController(text: AppModule.getProfileHolder().user.name);
  TextEditingController surnameController = TextEditingController(text:AppModule.getProfileHolder().user.surname);
  TextEditingController phoneController = TextEditingController(text:AppModule.getProfileHolder().user.phoneNumber);

  bool isMyProfile = false;
  int getLikes(List<Review> reviews) {
    int likes = 0;
    for (var element in reviews) {
      likes += element.likesCount;
    }
    return likes;
  }

  final _phoneMask = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  List<Review> reviews = [];
  User? user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      context.read<ProfileCubit>().loadProfile(user: user);
    }

    final double deviceHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ProfileCubit>().loadProfile(user: user, isUpdateInfo: true);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.status.runtimeType) {
              case LoadedStatus<User>:
                if(state.status.item!.id ==  AppModule.getProfileHolder().user.id){
                  isMyProfile = true;
                }
                reviews = state.userReviews.item!;
                return IntrinsicHeight(
                  child: Column(
                    children: [
                      profileCard(context),
                      statsWidget(
                        context: context,
                        user: state.status.item!,
                        countReview: state.userReviews.item!.length,
                        countTransfers: state.status.item!.activeTransfersCount,
                        books: state.status.item?.readerBooks,
                      ),
                      () {
                        if (user == null) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed('/create-transfer');
                                      },
                                      child: const Text("Отдать книгу"),
                                    ),
                                  ),
                                ),
                              ),
                              ProfileCategoryReviewWidget(
                                onFilterChanged: (value) => reviews = value,
                              ),
                            ],
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
                            return Text('${reviews.length} записей',
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
                return SizedBox(height: deviceHeight, child: const ProfileShimmerCard());
              case FailedStatus<User>:
                return SizedBox(
                    height: deviceHeight,
                    child: Center(
                        child: Text(
                            'Произошла ошибка при получении данных: ${state.status.message}')));
              default:
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
            .map((review) => ReviewWidget(review: review, isProfileReview: user == null))
            .toList(),
      ),
    );
  }

  Widget statsWidget(
      {required User user,
        required int countReview,
      required countTransfers,
      required List<Book>? books,
      required BuildContext context}) {
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
                InkWell(
                  onTap: () {
                    if (countTransfers != 0) {
                      Navigator.of(context).pushNamed('/user-transfers', arguments: user);
                    }
                  },
                  child: itemInStatsRow(title: 'Объявлений', value: countTransfers),
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                InkWell(
                  onTap: () {
                    if (books != null && books.isNotEmpty) {
                      Navigator.of(context).pushNamed('/book-profile', arguments: books);
                    }
                  },
                  child: itemInStatsRow(title: 'Книг', value: books?.length ?? 0),
                ),
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
          return AppBar(
            backgroundColor: Colors.transparent,
          );
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
              title: 'Редатировать профиль', icon: Icons.edit_outlined),
          PopupIconMenuItem(title: 'Выйти', icon: Icons.exit_to_app_outlined),
          PopupIconMenuItem(
            title: 'Сменить тему',
            icon: context.read<ThemeCubit>().getCurrentTheme == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 'Редатировать профиль':
              buildEditProfileWidget(context);
              break;
            case 'Выйти':
              AppModule.getPreferencesRepository().removeSavedProfile();
              Navigator.of(context).pushNamed('/sign-in');
              break;
            case 'Сменить тему':
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
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                          const Text(
                            'Редактирование профиля',
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
                                  return 'Введите имя';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Имя',
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
                                  return 'Введите фамилию';
                                }
                                return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Фамилия',
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
                      controller: phoneController,
                      inputFormatters: [_phoneMask],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Введите номер телефона';
                        }
                        return null;
                      },
                      maxLines: 1,
                      maxLength: 18,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '+7 (000) 000-00-00',
                        labelText: 'Номер телефона',
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
                        final phoneNumber = phoneController.value.text;
                        phoneController.clear();
                        surnameController.clear();
                        nameController.clear();

                        await context
                            .read<ProfileCubit>()
                            .updateProfile(
                                surname: surname, name: name, phoneNumber: phoneNumber)
                            .then((value) {
                          SnackBarInfo.show(
                              context: context,
                              message: 'Данные обновлены',
                              isSuccess: true);
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Text('Сохранить'),
                  ),
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
                    height: state.status.item!.status != null? 230 : 210,
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
                            () {
                              if (state.status.item!.status != null) {
                                return statusRow(state);
                              }
                              return const SizedBox();
                            }(),
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
                            case 'Открыть фото':
                              if (state.status.item!.image == null) {
                                SnackBarInfo.showTop(
                                    context: context,
                                    message: 'Фотографии еще нет',
                                    isSuccess: false);
                                break;
                              }
                              PhotoViewDialog(state.status.item!)
                                  .dialogBuilder(context);
                              break;
                            case 'Изменить фото':
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
                            case 'Удалить фото':
                              if (state.status.item!.image == null) {
                                SnackBarInfo.showTop(
                                    context: context,
                                    message: 'Фотографии еще нет',
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

  Row statusRow(ProfileState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Статус: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('${state.status.item!.status!.status}, (${state.status.item!.inactiveTransfersCount}/${state.status.item!.nextStatus!.count})'),
      ],
    );
  }

  List<PopupIconMenuItem> buttonsProfile = [
    PopupIconMenuItem(title: 'Открыть фото', icon: Icons.account_circle_outlined),
    PopupIconMenuItem(title: 'Изменить фото', icon: Icons.edit_outlined),
    PopupIconMenuItem(
        color: Colors.red, title: 'Удалить фото', icon: Icons.delete_outlined),
  ];
  List<PopupIconMenuItem> buttonsGuest = [
    PopupIconMenuItem(title: 'Открыть фото', icon: Icons.account_circle_outlined),
  ];
}
