import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/genre.dart';
import '../models_status.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreState());

  Future<void> loadGenres() async {
    final repository = AppModule.getGenreRepository();
    emit(state.copyWith(getGenresStatus: LoadingStatus<List<Genre>>()));
    try {
      final genres = await repository.getAllGenres();
      emit(state.copyWith(getGenresStatus: LoadedStatus<List<Genre>>(genres)));
    } catch (exception) {
      emit(state.copyWith(
          getGenresStatus: FailedStatus(
              state.getGenresStatus.message ?? exception.toString())));
    }
  }
}
