import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/book.dart';
import '../../../data/models/review.dart';
import '../../../data/models/user.dart';
import '../models_status.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState());

  Future<void> deleteReview(Review review) async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(deleteStatus: LoadingStatus()));
    try {
      await repository.deleteReview(review.id);
      emit(state.copyWith(deleteStatus: LoadedStatus(null)));
    } catch (exception) {
      emit(state.copyWith(
          deleteStatus: FailedStatus(
              state.deleteStatus.message ?? exception.toString())));
    }
  }

  Future<Review?> archiveReview(Review oldReview) async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(archiveStatus: LoadingStatus<Review>()));
    try {
      final review = await repository.archiveReview(oldReview.id);
      emit(state.copyWith(archiveStatus: LoadedStatus(review)));
      return review;
    } catch (exception) {
      emit(state.copyWith(
          archiveStatus: FailedStatus(
              state.archiveStatus.message ?? exception.toString())));
      return null;
    }
  }

  Future<Review?> unzipReview(Review oldReview) async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(archiveStatus: LoadingStatus<Review>()));
    try {
      final review = await repository.unzipReview(oldReview.id);
      emit(state.copyWith(archiveStatus: LoadedStatus(review)));
      return review;
    } catch (exception) {
      emit(state.copyWith(
          archiveStatus: FailedStatus(
              state.archiveStatus.message ?? exception.toString())));
      return null;
    }
  }

  Future<List<Review>?> loadReviews({String? filter, dynamic value}) async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(reviews: LoadingStatus()));
    try {
      final reviews =
          await repository.getAllReviews(filter: filter, value: value);
      emit(state.copyWith(reviews: LoadedStatus(reviews)));
      return reviews;
    } catch (exception) {
      emit(state.copyWith(reviews: FailedStatus(exception.toString())));
      return null;
    }
  }

  Future<List<Review>?> loadUserReview({int? isArchived}) async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(reviews: LoadingStatus()));
    try {
      final reviews = await repository.getUsersReview(
        id: AppModule.getProfileHolder().user.id,
        isArchive: isArchived,
      );
      emit(state.copyWith(reviews: LoadedStatus(reviews)));
      return reviews;
    } catch (exception) {
      emit(state.copyWith(reviews: FailedStatus(exception.toString())));
      return null;
    }
  }

  Future<void> createReview() async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(createReviewStatus: LoadingStatus<Review>()));
    try {
      print(state.title);
      print(state.text);
      print(state.book);
      print(state.rating);
      print(AppModule.getProfileHolder().user);
      final review = await repository.addReview(
        state.title,
        state.text,
        state.book!,
        state.rating,
        AppModule.getProfileHolder().user,
      );
      print('created review (review_cubit 36): $review');
      emit(state.copyWith(createReviewStatus: LoadedStatus(review)));
      emit(state.copyWith(createReviewStatus: const IdleStatus()));
    } catch (exception) {
      emit(state.copyWith(
          createReviewStatus: FailedStatus(
              state.createReviewStatus.message ?? exception.toString())));
    }
  }

  Future<void> titleChanged(String value) async {
    emit(state.copyWith(title: value));
  }

  Future<void> textChanged(String value) async {
    emit(state.copyWith(text: value));
  }

  Future<void> ratingChanged(int value) async {
    emit(state.copyWith(rating: value));
  }

  Future<void> bookChanged(Book value) async {
    emit(state.copyWith(book: value));
  }
}
