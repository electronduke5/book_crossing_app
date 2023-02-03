import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/book.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/book_repository.dart';

class BookRepositoryImpl with ApiService<Book> implements BookRepository {
  @override
  Future<List<Book>> getAllBooks() => getAll(
        fromJson: (Map<String, dynamic> json) => Book.fromJson(json),
      );

  @override
  String apiRoute = ApiConstUrl.bookUrl;
}
