part of 'review_cubit.dart';

class ReviewState {
  final ApiStatus<List<Review>> reviews;

  ReviewState({
    this.reviews = const IdleStatus(),
  });

  ReviewState copyWith({
    ApiStatus<List<Review>>? reviews,
  }) =>
      ReviewState(
        reviews: reviews ?? this.reviews,
      );
}
