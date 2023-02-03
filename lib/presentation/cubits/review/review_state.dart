part of 'review_cubit.dart';

class ReviewState {
  final ApiStatus<List<Review>> reviews;
  final String title;
  final String text;
  final Book? book;
  final User user = AppModule.getProfileHolder().user;

  ReviewState({
    this.reviews = const IdleStatus(),
    this.title = '',
    this.text = '',
    this.book
  });

  ReviewState copyWith({
    ApiStatus<List<Review>>? reviews,
    String? title,
    String? text,
    Book? book,
  }) =>
      ReviewState(
        reviews: reviews ?? this.reviews,
        title: title ?? this.title,
        text: text ?? this.text,
        book: book ?? this.book,
      );
}
