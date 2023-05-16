import 'dart:io';

import 'package:book_crossing_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/author/author_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/genre/genre_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/like/like_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/point/point_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/status/status_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/theme/theme_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/transfer/transfer_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/add_author_page.dart';
import 'package:book_crossing_app/presentation/pages/add_book_page.dart';
import 'package:book_crossing_app/presentation/pages/add_point_page.dart';
import 'package:book_crossing_app/presentation/pages/book_reviews_page.dart';
import 'package:book_crossing_app/presentation/pages/books_profile_page.dart';
import 'package:book_crossing_app/presentation/pages/transfer_pages/create_transfer_page.dart';
import 'package:book_crossing_app/presentation/pages/main_page.dart';
import 'package:book_crossing_app/presentation/pages/profile_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_in_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_up_page.dart';
import 'package:book_crossing_app/presentation/pages/start_page.dart';
import 'package:book_crossing_app/presentation/pages/transfer_pages/transfer_view_page.dart';
import 'package:book_crossing_app/presentation/pages/transfer_pages/user_transfers_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repositories/preferenses_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  late PreferencesRepository _preferencesRepository;

  MyApp({super.key}) {
    _preferencesRepository = AppModule.getPreferencesRepository();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;

  @override
  void didChangeDependencies() async {
    prefs = await SharedPreferences.getInstance();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._preferencesRepository.getUser(),
      builder: (context, user) {
        if (user.connectionState != ConnectionState.done) {
          return const StartPage();
        }
        return BlocProvider(
          create: (context) => ThemeCubit(prefs),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) => MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: FlexThemeData.light(
                scheme: FlexScheme.blueWhale,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 20,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 10,
                  blendOnColors: false,
                  inputDecoratorIsFilled: false,
                  inputDecoratorRadius: 25.0,
                  cardRadius: 15.0,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,
                fontFamily: GoogleFonts.notoSerif().fontFamily,
              ),
              darkTheme: FlexThemeData.dark(
                scheme: FlexScheme.blueWhale,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 20,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 20,
                  inputDecoratorIsFilled: false,
                  inputDecoratorRadius: 25.0,
                  cardRadius: 15.0,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,
                fontFamily: GoogleFonts.notoSerif().fontFamily,
              ),
              themeMode: context.read<ThemeCubit>().getCurrentTheme,
              routes: {
                '/sign-in': (context) => BlocProvider<AuthCubit>(
                      create: (context) => AuthCubit(),
                      child: SignInPage(),
                    ),
                '/sign-up': (context) => BlocProvider<AuthCubit>(
                      create: (context) => AuthCubit(),
                      child: SignUpPage(),
                    ),
                '/add-author': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthorCubit>(
                            create: (context) => AuthorCubit()..loadAuthors()),
                      ],
                      child: AddAuthorPage(),
                    ),
                '/book-review': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<LikeCubit>(create: (context) => LikeCubit()),
                        BlocProvider<ReviewCubit>(create: (context) => ReviewCubit()),
                      ],
                      child: BookReviewPage(),
                    ),
                // child: MainPage(
                //       bodyWidget: BookReviewPage(),
                //     ),
                //   ),
                '/book-profile': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<LikeCubit>(create: (context) => LikeCubit()),
                        BlocProvider<ReviewCubit>(create: (context) => ReviewCubit()),
                        BlocProvider<ProfileCubit>(
                            create: (context) => ProfileCubit()..loadProfile()),
                        BlocProvider<BookCubit>(
                            create: (context) => BookCubit()..loadBooks()),
                      ],
                      child: BookProfilePage(),
                    ),
                '/user-transfers': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ProfileCubit>(
                        create: (context) => ProfileCubit()..loadProfile()),
                    BlocProvider<TransferCubit>(
                        create: (context) => TransferCubit()),
                  ],
                  child: UserTransfersPage(),
                ),
                '/transfer-view-page': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ProfileCubit>(
                        create: (context) => ProfileCubit()),
                    BlocProvider<TransferCubit>(
                        create: (context) => TransferCubit()),
                  ],
                  child: TransferViewPage(),
                ),
                '/create-transfer': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<TransferCubit>(create: (context) => TransferCubit()),
                        BlocProvider<BookCubit>(
                            create: (context) => BookCubit()
                              ..loadBooksForTransfer(
                                  user: AppModule.getProfileHolder().user)),
                        BlocProvider<PointCubit>(
                            create: (context) => PointCubit()
                              ..loadUsersPoints(AppModule.getProfileHolder().user)),
                        BlocProvider<StatusCubit>(create: (context) => StatusCubit()),
                        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
                      ],
                      child: CreateTransferPage(),
                    ),
                '/add-book': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthorCubit>(
                            create: (context) => AuthorCubit()..loadAuthors()),
                        BlocProvider<GenreCubit>(
                            create: (context) => GenreCubit()..loadGenres()),
                        BlocProvider<BookCubit>(
                            create: (context) => BookCubit()..loadBooks()),
                      ],
                      child: AddBookPage(),
                    ),
                '/add-point': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<PointCubit>(create: (context) => PointCubit()),
                  ],
                  child: AddPointPage(),
                ),
                '/profile-page': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<LikeCubit>(
                            create: (context) => LikeCubit()),
                        BlocProvider<ProfileCubit>(
                            create: (context) => ProfileCubit()),
                        BlocProvider<BookCubit>(
                            create: (context) => BookCubit()..loadBooks()),
                        BlocProvider<ReviewCubit>(
                            create: (context) => ReviewCubit()..loadReviews()),
                      ],
                      child: Scaffold(
                        body: SafeArea(
                          child: ProfilePage(),
                        ),
                      ),
                    ),
                '/main': (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<LikeCubit>(
                            create: (context) => LikeCubit()),
                        BlocProvider<ProfileCubit>(
                            create: (context) => ProfileCubit()..loadProfile()),
                        BlocProvider<BookCubit>(
                            create: (context) => BookCubit()..loadBooks()),
                        BlocProvider<ReviewCubit>(
                            create: (context) => ReviewCubit()..loadReviews()),
                      ],
                      child: MainPage(selectedIndex: ModalRoute.of(context)!.settings.arguments as int?),
                    ),
              },
              initialRoute: user.data == null ? '/sign-in' : '/main',
            ),
          ),
        );
      },
    );
  }
}
