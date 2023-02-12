import 'dart:io';

import 'package:book_crossing_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/author/author_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/book/book_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/genre/genre_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/like/like_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/review/review_cubit.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/add_author_page.dart';
import 'package:book_crossing_app/presentation/pages/add_book_page.dart';
import 'package:book_crossing_app/presentation/pages/book_reviews_page.dart';
import 'package:book_crossing_app/presentation/pages/main_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_in_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_up_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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

class MyApp extends StatelessWidget {
  late PreferencesRepository _preferencesRepository;

  MyApp({super.key}) {
    _preferencesRepository = AppModule.getPreferencesRepository();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _preferencesRepository.getUser(),
      builder: (context, user) {
        if (user.connectionState != ConnectionState.done) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                () {
                  int datetime = DateTime.now().hour;
                  if (datetime >= 6 && datetime < 12) {
                    return Lottie.asset(
                      'assets/lottie/background_day.json',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    );
                  } else if (datetime >= 12 && datetime < 18) {
                    return Lottie.asset(
                      'assets/lottie/background.json',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    );
                  } else {
                    return Lottie.asset(
                      'assets/lottie/background_night.json',
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    );
                  }
                }(),
                Positioned(
                  top: 150,
                  child: Text(
                    'Добро пожаловать!',
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: GoogleFonts.notoSerif().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: FlexThemeData.light(
            //background: const Color.fromRGBO(224, 224, 224, 1),
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
            //swapColors: true,
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
          themeMode: ThemeMode.dark,
          routes: {
            '/sign-in': (context) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: SignInPage(),
                ),
            '/sign-up': (context) => BlocProvider<AuthCubit>(
                  create: (context) => AuthCubit(),
                  child: const SignUpPage(),
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
                    BlocProvider<ReviewCubit>(
                        create: (context) => ReviewCubit()),
                  ],
                  child: BookReviewPage(),
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
            '/main': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LikeCubit>(create: (context) => LikeCubit()),
                    BlocProvider<ProfileCubit>(
                        create: (context) => ProfileCubit()..loadProfile()),
                    BlocProvider<BookCubit>(
                        create: (context) => BookCubit()..loadBooks()),
                    BlocProvider<ReviewCubit>(
                        create: (context) => ReviewCubit()..loadReviews()),
                  ],
                  child: const MainPage(),
                ),
          },
          initialRoute: user.data == null ? '/sign-in' : '/main',
        );
      },
    );
  }
}
