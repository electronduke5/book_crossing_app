import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/review.dart';
import '../models_status.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState());

  Future<void> loadReviews() async {
    final repository = AppModule.getReviewRepository();
    emit(state.copyWith(reviews: LoadingStatus()));
    try {
      final reviews = await repository.getAllReviews();
      emit(state.copyWith(reviews: LoadedStatus(reviews)));
    } catch (exception) {
      emit(state.copyWith(reviews: FailedStatus(exception.toString())));
    }
  }
}
