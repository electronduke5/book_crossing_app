import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/author.dart';

import '../../domain/repositories/author_repository.dart';
import '../utils/api_const_url.dart';

class AuthorRepositoryImpl with ApiService<Author> implements AuthorRepository {
  @override
  String apiRoute = ApiConstUrl.authorUrl;

  @override
  Future<Author> createAuthor(
    String surname,
    String name,
    String? patronymic,
  ) =>
      post(
        fromJson: (Map<String, dynamic> json) => Author.fromJson(json),
        data: {
          'surname': surname,
          'name': name,
          'patronymic': patronymic,
        },
      );

  @override
  Future<List<Author>> getAllAuthors() => getAll(
        fromJson: (Map<String, dynamic> json) => Author.fromJson(json),
      );
}
