part of 'genre_cubit.dart';

class GenreState {
  ApiStatus<List<Genre>> getGenresStatus;

  GenreState({
    this.getGenresStatus = const IdleStatus(),
  });

  GenreState copyWith({
    ApiStatus<List<Genre>>? getGenresStatus,
  }) {
    return GenreState(
      getGenresStatus: getGenresStatus ?? this.getGenresStatus,
    );
  }
}
