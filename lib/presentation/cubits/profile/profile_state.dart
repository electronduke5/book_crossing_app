part of 'profile_cubit.dart';

class ProfileState {
  final ApiStatus<User> status;
  final ApiStatus<List<Review>> userReviews;
  // final ApiStatus<List<Book>> ownerBooks;
  // final ApiStatus<List<Book>> readerBooks;

  ProfileState({
    this.status = const IdleStatus(),
    this.userReviews = const IdleStatus(),
    // this.ownerBooks = const IdleStatus(),
    // this.readerBooks = const IdleStatus(),
  });

  ProfileState copyWith({
    ApiStatus<User>? status,
    ApiStatus<List<Review>>? userReviews,
    // ApiStatus<List<Book>>? ownerBooks,
    // ApiStatus<List<Book>>? readerBooks,
  }) =>
      ProfileState(
        status: status ?? this.status,
        userReviews: userReviews ?? this.userReviews,
        // readerBooks: readerBooks ?? this.readerBooks,
        // ownerBooks: ownerBooks ?? this.ownerBooks,
      );
}
