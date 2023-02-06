import '../../data/models/genre.dart';

abstract class GenreRepository {
  Future<List<Genre>> getAllGenres();
}
