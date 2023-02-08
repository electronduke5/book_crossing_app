import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/review/review_cubit.dart';

class ReviewTitle extends StatelessWidget {
  const ReviewTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) =>
          context.read<ReviewCubit>().titleChanged(value),
      validator: (value) {
        if (value?.trim().isNotEmpty == true) {
          return null;
        }
        return "Это обязательное поле";
      },
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10.0),
        labelText: 'Заголовок',
        prefixIcon: const Icon(Icons.title),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)),
        hintText: 'Заголовок',
      ),
    );
  }
}
