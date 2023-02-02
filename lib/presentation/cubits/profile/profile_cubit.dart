import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadProfile() async {
    final repository = AppModule.getProfileRepository();
    emit(state.copyWith(status: LoadingStatus()));
    try {
      final user = await repository.getProfile();
      emit(state.copyWith(status: LoadedStatus(user)));
    } catch (exception) {
      emit(state.copyWith(status: FailedStatus(exception.toString())));
    }
  }
}
