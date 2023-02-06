import 'package:book_crossing_app/data/models/author.dart';

abstract class AuthorRepository {
  Future<List<Author>> getAllAuthors();

  Future<Author> createAuthor(String surname, String name, String? patronymic);
}
