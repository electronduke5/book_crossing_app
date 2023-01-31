import 'package:book_crossing_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/main_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_in_page.dart';
import 'package:book_crossing_app/presentation/pages/sign_up_page.dart';
import 'package:book_crossing_app/presentation/widgets/snack_bar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          inputDecoratorIsFilled: false,
          inputDecoratorRadius: 25.0,
          cardRadius: 16.0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.redWine,
        //scheme: FlexScheme.redWine,
        //scheme: FlexScheme.mandyRed,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          inputDecoratorIsFilled: false,
          inputDecoratorRadius: 25.0,
          cardRadius: 16.0,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      themeMode: ThemeMode.system,
      routes: {
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
      },
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: MainPage(),
      ),
    );
  }
}

class SignInPage2 extends StatelessWidget {
  SignInPage2({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              print(state.apiStatus.runtimeType);
              if (state.apiStatus is FailedStatus) {
                SnackBarInfo.show(
                  context: context,
                  message: state.apiStatus.message ?? 'Ошибка какая то блять',
                  isSuccess: false,
                );
              } else if (state.apiStatus is LoadedStatus) {
                SnackBarInfo.show(
                  context: context,
                  message: state.apiStatus.item.toString(),
                  isSuccess: true,
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                print(state.apiStatus.runtimeType);
                switch (state.apiStatus.runtimeType) {
                  case LoadedStatus<User>:
                    return Center(
                      child: Column(
                        children: [
                          Text(state.apiStatus.item!.name),
                          Text(state.apiStatus.item!.email),
                          Text(state.apiStatus.item!.surname),
                        ],
                      ),
                    );

                  case IdleStatus<User>:
                    print('idle');
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) =>
                                context.read<AuthCubit>().emailChanged(value),
                            decoration: const InputDecoration(
                              labelText: 'email',
                            ),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                          ),
                          const SizedBox(height: 40),
                          TextFormField(
                            onChanged: (value) => context
                                .read<AuthCubit>()
                                .passwordChanged(value),
                            decoration: const InputDecoration(
                              labelText: 'password',
                            ),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                          ),
                          const SizedBox(height: 40),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  print(state.email);
                                  print(state.password);
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<AuthCubit>().signIn();
                                  // SnackBarInfo.show(
                                  //   context: context,
                                  //   message:
                                  //       state.apiStatus.item!.name.toString(),
                                  //   isSuccess: false,
                                  // );
                                  // Navigator.of(context)
                                  //     .pushReplacementNamed('/profile');
                                },
                                child: state.apiStatus is LoadedStatus
                                    ? const CircularProgressIndicator()
                                    : const Text('Войти'),
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("/sign-up");
                            },
                            child: const Text(
                              'Ещё нет профиля?',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  case FailedStatus<User>:
                    return Center(
                      child: Text(state.apiStatus.message ?? 'шибка где-то'),
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
