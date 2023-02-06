import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/author.dart';
import 'package:book_crossing_app/data/models/book.dart';
import 'package:book_crossing_app/data/models/genre.dart';
import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/book_repository.dart';

class BookRepositoryImpl with ApiService<Book> implements BookRepository {
  @override
  Future<List<Book>> getAllBooks() => getAll(
        fromJson: (Map<String, dynamic> json) => Book.fromJson(json),
      );

  @override
  String apiRoute = ApiConstUrl.bookUrl;

  @override
  Future<Book> createBook(String title, String? description, String? image,
      double? rating, Author author, Genre genre, User owner, User reader) {
    return post(
      fromJson: (Map<String, dynamic> json) => Book.fromJson(json),
      data: {
        'title': title,
        'description': description,
        'image': image,
        'rating': rating,
        'author_id': author.id,
        'genre_id': genre.id,
        'owner_id': owner.id,
        'reader_id': reader.id,
      },
    );
  }
}
