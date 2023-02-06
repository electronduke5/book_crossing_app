part of 'book_cubit.dart';

class BookState {
  final ApiStatus<List<Book>> booksStatus;
  final ApiStatus<Book> addBookStatus;
  final String title;
  final String description;
  final String image;
  final double rating;
  final Author? author;
  final Genre? genre;
  final User owner = AppModule.getProfileHolder().user;
  final User reader = AppModule.getProfileHolder().user;

  BookState({
    this.booksStatus = const IdleStatus(),
    this.addBookStatus = const IdleStatus(),
    this.genre,
    this.author,
    this.title = '',
    this.image = '',
    this.description = '',
    this.rating = 0.0,
  });

  BookState copyWith({
    ApiStatus<List<Book>>? booksStatus,
    ApiStatus<Book>? addBookStatus,
    String? title,
    String? description,
    String? image,
    double? rating,
    Author? author,
    Genre? genre,
  }) =>
      BookState(
        booksStatus: booksStatus ?? this.booksStatus,
        addBookStatus: addBookStatus ?? this.addBookStatus,
        title: title ?? this.title,
        image: image ?? this.image,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        author: author ?? this.author,
        genre: genre ?? this.genre,
      );
}
