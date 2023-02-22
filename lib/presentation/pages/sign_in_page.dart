import 'package:book_crossing_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/user.dart';
import '../widgets/snack_bar.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print(state.apiStatus.runtimeType);
            switch (state.apiStatus.runtimeType) {
              case FailedStatus<User>:
                SnackBarInfo.show(
                  context: context,
                  message: state.apiStatus.message?.substring(11) ?? 'Неверный логин или пароль',
                  isSuccess: false,
                );
                context
                    .read<AuthCubit>()
                    .state
                    .copyWith(apiStatus: const IdleStatus());
                break;
              case LoadedStatus<User>:
                Navigator.of(context).pushReplacementNamed('/main');
                break;
            }
          },
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Lottie.asset(
                    alignment: Alignment.topCenter,
                    'assets/lottie/sign_in.json',
                    repeat: false,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(0),
                        top: Radius.circular(20),
                      ),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 13.0, top: 7, bottom: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'С возвращением!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const Text(
                              'Пожалуйста, войдите в свой профиль',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              onChanged: (value) =>
                                  context.read<AuthCubit>().emailChanged(value),
                              validator: (value) {
                                if (value?.trim().isNotEmpty == true) {
                                  return null;
                                }
                                return "Это обязательное поле";
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                labelText: 'Эл. адрес',
                                prefixIcon: const Icon(Icons.alternate_email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'example@mail.ru',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<AuthCubit>()
                                  .passwordChanged(value),
                              validator: (value) {
                                if (value?.trim().isNotEmpty == true) {
                                  return null;
                                }
                                return "Это обязательное поле";
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                labelText: 'Пароль',
                                prefixIcon: const Icon(Icons.password),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Password123',
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: double.infinity,
                                child: BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                      onPressed: () {
                                        print(state.email);
                                        print(state.password);
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().signIn();
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: state.apiStatus.runtimeType
                                                is LoadedStatus<User>
                                            ? const CircularProgressIndicator()
                                            : const Text('ВОЙТИ В ПРОФИЛЬ'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/sign-up');
                                },
                                child: const Text(
                                  'Ещё нет профиля?',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
