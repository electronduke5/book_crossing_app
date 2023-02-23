import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/review.dart';
import '../../../data/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadProfile({int? isArchived, User? user}) async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final loadedUser = await repository.getProfile(user: user);
      final userReviews =
          await reviewRepo.getUsersReview(id: loadedUser.id, isArchive: isArchived);
      emit(state.copyWith(
          status: LoadedStatus(loadedUser), userReviews: LoadedStatus(userReviews)));
    } catch (exception) {
      emit(state.copyWith(status: FailedStatus(exception.toString())));
    }
  }

  Future<User?> updateProfile(String surname, String name) async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final updatedUser =
          await repository.updateProfile(surname: surname, name: name);
      final userReviews = await reviewRepo.getUsersReview(id: updatedUser.id);
      emit(state.copyWith(
        status: LoadedStatus(updatedUser),
        userReviews: LoadedStatus(userReviews),
      ));
      return updatedUser;
    } catch (exception) {
      emit(state.copyWith(
          status: FailedStatus(state.status.message ?? exception.toString())));
      return null;
    }
  }
}
