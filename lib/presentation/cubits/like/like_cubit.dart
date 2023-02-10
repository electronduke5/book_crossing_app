import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';

import '../../../data/models/review.dart';

import '../../../data/models/user.dart';
import '../../di/app_module.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeState());

  Future<Review?> likeBook(Review review) async {
    final repository = AppModule.getLikeRepository();
    final User user = AppModule.getProfileHolder().user;
    emit(state.copyWith(likeStatus: LoadingStatus()));
    try {
      final  likeReview = await repository.likeReview(review: review, user: user);
      emit(state.copyWith(likeStatus: LoadedStatus(likeReview)));
      return likeReview;
    } catch (exception) {
      emit(state.copyWith(likeStatus: FailedStatus(exception.toString())));
      return null;
    }
  }

}
