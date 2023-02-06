import 'package:book_crossing_app/data/models/author.dart';

import '../../data/models/book.dart';
import '../../data/models/genre.dart';
import '../../data/models/user.dart';

abstract class BookRepository {
  Future<List<Book>> getAllBooks();

  Future<Book> createBook(
    String title,
    String? description,
    String? image,
    double? rating,
    Author author,
    Genre genre,
    User owner,
    User reader,
  );
}
