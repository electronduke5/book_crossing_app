import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/book.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookState());

  Future<void> loadBooks() async {
    final repository = AppModule.getBookRepository();
    emit(state.copyWith(booksStatus: LoadingStatus()));
    try {
      final books = await repository.getAllBooks();
      emit(state.copyWith(booksStatus: LoadedStatus(books)));
    } catch (exception) {
      emit(
          state.copyWith(booksStatus: FailedStatus(state.booksStatus.message)));
    }
  }
}
