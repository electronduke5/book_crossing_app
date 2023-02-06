import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:book_crossing_app/domain/repositories/genre_repository.dart';

import '../api_service.dart';
import '../models/genre.dart';

class GenreRepositoryImpl with ApiService<Genre> implements GenreRepository {
  @override
  String apiRoute = ApiConstUrl.genreUrl;

  @override
  Future<List<Genre>> getAllGenres() {
    return getAll(
      fromJson: (Map<String, dynamic> json) => Genre.fromJson(json),
    );
  }
}
