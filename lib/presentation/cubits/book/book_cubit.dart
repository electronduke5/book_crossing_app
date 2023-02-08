import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/data/models/genre.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/author.dart';
import '../../../data/models/book.dart';
import '../../../data/models/user.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookState());

  Future<void> loadBooks() async {
    print('state: ${state.booksStatus.runtimeType}');
    final repository = AppModule.getBookRepository();
    emit(state.copyWith(booksStatus: LoadingStatus()));
    try {
      print('state2: ${state.booksStatus.runtimeType}');
      final List<Book> books = await repository.getAllBooks();
      print(books);
      print('state2.4: ${state.booksStatus.runtimeType}');
      emit(state.copyWith(booksStatus: LoadedStatus(books)));
      print('state3: ${state.booksStatus.runtimeType}');
    } catch (exception) {
      print('state Error: ${state.booksStatus.runtimeType}');
      emit(
          state.copyWith(booksStatus: FailedStatus(state.booksStatus.message)));
      print('4: ${state.booksStatus.runtimeType}');
    }
  }

  Future<Book?> addBook() async {
    final repository = AppModule.getBookRepository();
    emit(state.copyWith(addBookStatus: LoadingStatus<Book>()));
    try {
      final book = await repository.createBook(
        state.title,
        state.description,
        state.image,
        state.rating,
        state.author!,
        state.genre!,
        AppModule.getProfileHolder().user,
        AppModule.getProfileHolder().user,
      );
      print('created book (book_cubit 41): $book');
      emit(state.copyWith(addBookStatus: LoadedStatus(book)));
      return book;
    } catch (exception) {
      emit(state.copyWith(
          addBookStatus: FailedStatus(
              state.addBookStatus.message ?? exception.toString())));
      emit(state.copyWith(addBookStatus: const IdleStatus()));
      return null;
    }
  }

  Future<void> titleChanged(String value) async {
    emit(state.copyWith(title: value));
  }

  Future<void> descriptionChanged(String value) async {
    emit(state.copyWith(description: value));
  }

  Future<void> imageChanged(String value) async {
    emit(state.copyWith(image: value));
  }

  Future<void> ratingChanged(double value) async {
    emit(state.copyWith(rating: value));
  }

  Future<void> authorChanged(Author value) async {
    emit(state.copyWith(author: value));
  }

  Future<void> genreChanged(Genre value) async {
    emit(state.copyWith(genre: value));
  }
}
