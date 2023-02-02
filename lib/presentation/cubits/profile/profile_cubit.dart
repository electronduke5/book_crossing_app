import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/review.dart';
import '../../../data/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadProfile() async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final user = await repository.getProfile();
      print('user ok: $user');
      final userReviews = await reviewRepo.getUsersReview(user.id);
      print('reviews ok: $userReviews');
      emit(
          state.copyWith(status: LoadedStatus(user), userReviews: LoadedStatus(userReviews)));
    } catch (exception) {
      emit(state.copyWith(status: FailedStatus(exception.toString())));
    }
  }
}
