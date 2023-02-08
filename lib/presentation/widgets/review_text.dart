import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/review/review_cubit.dart';

class ReviewText extends StatelessWidget {
  const ReviewText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) =>
          context.read<ReviewCubit>().textChanged(value),
      validator: (value) {
        if (value?.trim().isNotEmpty == true) {
          return null;
        }
        return "Это обязательное поле";
      },
      maxLines: null,
      minLines: 2,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 10),
        labelText: 'Текст статьи',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)),
        hintText: 'Это моя новая рецензия на книгу...',
      ),
    );
  }
}
