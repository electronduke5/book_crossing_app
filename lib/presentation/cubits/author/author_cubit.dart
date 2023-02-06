import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/author.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit() : super(AuthorState());

  Future<void> loadAuthors() async {
    final repository = AppModule.getAuthorRepository();
    emit(state.copyWith(getAuthorsState: LoadingStatus()));
    try {
      final authors = await repository.getAllAuthors();
      emit(state.copyWith(getAuthorsState: LoadedStatus(authors)));
    } catch (exception) {
      emit(state.copyWith(
          getAuthorsState: FailedStatus(state.getAuthorsState.message)));
    }
  }

  Future<Author?> addAuthor() async {
    final repository = AppModule.getAuthorRepository();
    emit(state.copyWith(addAuthorStatus: LoadingStatus()));
    try {
      final author = await repository.createAuthor(
          state.surname, state.name, state.patronymic);
      emit(state.copyWith(addAuthorStatus: LoadedStatus(author)));
      return author;
    } catch (exception) {
      emit(state.copyWith(
          addAuthorStatus: FailedStatus(state.addAuthorStatus.message)));
      emit(state.copyWith(addAuthorStatus: const IdleStatus()));
      return null;
    }
  }

  Future<void> surnameChanged(String value) async {
    emit(state.copyWith(surname: value));
  }

  Future<void> nameChanged(String value) async {
    emit(state.copyWith(name: value));
  }

  Future<void> patronymicChanged(String value) async {
    emit(state.copyWith(patronymic: value));
  }
}
