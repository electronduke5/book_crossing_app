import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/author/author_cubit.dart';

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
      body: SingleChildScrollView(
        child: BlocBuilder<AuthorCubit, AuthorState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      validator: (value) {},
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
                          print('добавлено');
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
                      child: Text("Далее"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: Text("Назад"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
