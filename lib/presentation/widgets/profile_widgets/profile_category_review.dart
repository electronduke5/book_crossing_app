import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/review.dart';
import '../../cubits/review/review_cubit.dart';

class ProfileCategoryReviewWidget extends StatefulWidget {
  const ProfileCategoryReviewWidget({Key? key, required this.onFilterChanged})
      : super(key: key);
  final ValueChanged<List<Review>> onFilterChanged;

  @override
  State<ProfileCategoryReviewWidget> createState() =>
      _ProfileCategoryReviewWidgetState();
}

class _ProfileCategoryReviewWidgetState
    extends State<ProfileCategoryReviewWidget> {
  bool isAllReview = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Card(
        margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (isAllReview) return;
                    setState(() {
                      isAllReview = true;
                    });
                    await context.read<ReviewCubit>().loadUserReview().then(
                      (value) {
                        widget.onFilterChanged(value!);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    backgroundColor: isAllReview
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                  ),
                  child: Text(
                    'Мои ревью',
                    style: TextStyle(
                      fontWeight: isAllReview ? FontWeight.bold : FontWeight.normal,
                      color: isAllReview
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!isAllReview) return;
                    setState(() {
                      isAllReview = false;
                    });
                    await context
                        .read<ReviewCubit>()
                        .loadUserReview(isArchived: 1)
                        .then((value) {
                      widget.onFilterChanged(value!);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    backgroundColor: isAllReview
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.inversePrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                  ),
                  child: Text(
                    'Архив ревью',
                    style: TextStyle(
                      fontWeight: isAllReview ? FontWeight.normal : FontWeight.bold,
                      color: isAllReview
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
