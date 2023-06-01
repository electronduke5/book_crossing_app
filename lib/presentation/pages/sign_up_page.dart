import 'package:book_crossing_app/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/user.dart';
import '../cubits/models_status.dart';
import '../widgets/snack_bar.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            switch (state.apiStatus.runtimeType) {
              case FailedStatus<User>:
                SnackBarInfo.show(
                      context: context,
                      message: state.apiStatus.message?.substring(11) ??
                          'Что-то не так..',
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: SvgPicture.asset(
                    'assets/lottie/sign_up.svg',
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
                                'Добро пожаловать!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const Text(
                                'Пора создать свой профиль...',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _surnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Это обязательное поле";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  labelText: 'Фамилия',
                                  prefixIcon: Icon(Icons.badge),
                                  hintText: 'Иванов',
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Это обязательное поле";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  labelText: 'Имя',
                                  prefixIcon: Icon(Icons.face_6),
                                  hintText: 'Иван',
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _loginController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Это обязательное поле";
                                  }
                                  if (value.trim().contains('@') == false) {
                                    return "Некорректный адрес";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  labelText: 'Эл. адрес',
                                  prefixIcon: Icon(Icons.alternate_email),
                                  hintText: 'example@mail.ru',
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Это обязательное поле";
                                  }
                                  if (value.trim().length < 8) {
                                    return "Пароль должен быть не менее 8 символов";
                                  }
                                  if (value.trim().contains(RegExp(r'[0-9]')) ==
                                      false) {
                                    return "Пароль должен содержать цифры";
                                  }
                                  if (value.trim().contains(RegExp(r'[A-Z]')) ==
                                      false) {
                                    return "Пароль должен содержать заглавные буквы";
                                  }
                                  if (value.trim().contains(RegExp(r'[a-z]')) ==
                                      false) {
                                    return "Пароль должен содержать строчные буквы";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  labelText: 'Пароль',
                                  prefixIcon: Icon(Icons.password),
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
                                        backgroundColor:
                                            Theme.of(context).colorScheme.primary,
                                        foregroundColor:
                                            Theme.of(context).colorScheme.onPrimary,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          String surname = _surnameController.value.text;
                                          String name = _nameController.value.text;
                                          String email = _loginController.value.text;
                                          String password =
                                              _passwordController.value.text;
                                          _surnameController.clear();
                                          _nameController.clear();
                                          _loginController.clear();
                                          _passwordController.clear();
                                          context.read<AuthCubit>().signUp(
                                              surname: surname,
                                              name: name,
                                              email: email,
                                              password: password);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: state.apiStatus.runtimeType
                                                is LoadedStatus<User>
                                            ? const CircularProgressIndicator()
                                            : const Text('СОЗДАТЬ ПРОФИЛЬ'),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/sign-in');
                                  },
                                  child: const Text(
                                    'Уже есть профиль?',
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
            ],
          ),
        ),
      ),
    );
  }
}
