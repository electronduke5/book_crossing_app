import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/author/author_cubit.dart';
import '../di/app_module.dart';
import '../widgets/profile_widgets/profile_image_small.dart';

class AddAuthorPage extends StatefulWidget {
  AddAuthorPage({Key? key}) : super(key: key);

  @override
  State<AddAuthorPage> createState() => _AddBookAuthorState();
}

class _AddBookAuthorState extends State<AddAuthorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: ProfileAvatarSmall(
                    maxRadius: 15, user: AppModule.getProfileHolder().user),
              ),
              title: const Text(
                'Добавление автора',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: BlocBuilder<AuthorCubit, AuthorState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          const Text('Для начала нужно добавить автора новой книги:'),
                          TextFormField(
                            onChanged: (value) =>
                                context.read<AuthorCubit>().surnameChanged(value),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              labelText: 'Фамилия',
                              prefixIcon: const Icon(Icons.looks_one_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Пушкин',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) =>
                                context.read<AuthorCubit>().nameChanged(value),
                            validator: (value) {
                              if (value?.trim().isNotEmpty == true) {
                                return null;
                              }
                              return "Это обязательное поле";
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              labelText: 'Имя',
                              prefixIcon: const Icon(Icons.looks_two_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Александр',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) =>
                                context.read<AuthorCubit>().patronymicChanged(value),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              labelText: 'Отчество',
                              prefixIcon: const Icon(Icons.looks_3_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Сергеевич',
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await context
                                    .read<AuthorCubit>()
                                    .addAuthor()
                                    .then((value) {
                                  if (value != null) {
                                    Navigator.pop(context, value);
                                  }
                                });
                              }
                            },
                            child: const Text("Далее"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            child: const Text("Назад"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
