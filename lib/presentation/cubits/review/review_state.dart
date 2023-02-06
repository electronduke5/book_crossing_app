part of 'review_cubit.dart';

class ReviewState {
  final ApiStatus<List<Review>> reviews;
  final ApiStatus<Review> createReviewStatus;
  final String title;
  final String text;
  final int rating;
  final Book? book;
  final User user = AppModule.getProfileHolder().user;

  ReviewState(
      {this.createReviewStatus = const IdleStatus(),
      this.reviews = const IdleStatus(),
      this.title = '',
      this.text = '',
      this.rating = 0,
      this.book});

  ReviewState copyWith({
    ApiStatus<List<Review>>? reviews,
    ApiStatus<Review>? createReviewStatus,
    String? title,
    String? text,
    int? rating,
    Book? book,
  }) =>
      ReviewState(
          createReviewStatus: createReviewStatus ?? this.createReviewStatus,
          reviews: reviews ?? this.reviews,
          title: title ?? this.title,
          text: text ?? this.text,
          book: book ?? this.book,
          rating: rating ?? this.rating);
}
