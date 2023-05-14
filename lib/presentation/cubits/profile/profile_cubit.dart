import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/review.dart';
import '../../../data/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadProfile(
      {int? isArchived, User? user, bool isUpdateInfo = false}) async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    //final bookRepo = AppModule.getBookRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      User loadedUser;
      if (user != null && isUpdateInfo) {
        loadedUser = await repository.getProfileFromAPI(user: user);
      }
      loadedUser = await repository.getProfile(user: user);
      final userReviews =
          await reviewRepo.getUsersReview(id: loadedUser.id, isArchive: isArchived);
      // final userOwnerBooks = await bookRepo.getOwnerBooks(user!);
      // final userReaderBooks = await bookRepo.getOwnerBooks(user!);
      emit(
        state.copyWith(
          status: LoadedStatus(loadedUser),
          userReviews: LoadedStatus(userReviews),
          // ownerBooks: LoadedStatus(userOwnerBooks),
          // readerBooks: LoadedStatus(userReaderBooks),
        ),
      );
    } catch (exception) {
      emit(state.copyWith(status: FailedStatus(exception.toString())));
    }
  }

  Future<User?> updateProfile(
      {String? surname, String? name, File? image, String? phoneNumber}) async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final updatedUser = await repository.updateProfile(
          surname: surname, name: name, image: image, phoneNumber: phoneNumber);
      final userReviews = await reviewRepo.getUsersReview(id: updatedUser.id);

      print('oldUser: ${AppModule.getProfileHolder().user}');
      AppModule.getProfileHolder().user = updatedUser;

      print('updatedUser: ${updatedUser}');
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

  Future<User?> removeProfileImage() async {
    final repository = AppModule.getProfileRepository();
    final reviewRepo = AppModule.getReviewRepository();
    emit(state.copyWith(status: LoadingStatus<User>()));
    try {
      final newUser =
          await repository.removeImage(AppModule.getProfileHolder().user.id);
      final userReviews = await reviewRepo.getUsersReview(id: newUser.id);
      AppModule.getProfileHolder().user = newUser;
      emit(state.copyWith(
        status: LoadedStatus(newUser),
        userReviews: LoadedStatus(userReviews),
      ));
      return newUser;
    } catch (exception) {
      emit(state.copyWith(
          status: FailedStatus(state.status.message ?? exception.toString())));
      return null;
    }
  }
}
