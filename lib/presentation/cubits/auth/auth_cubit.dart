import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user.dart';
import '../models_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> signIn() async {
    final repository = AppModule.getAuthRepository();
    emit(state.copyWith(apiStatus: LoadingStatus()));
    try{
      final user = await repository.signIn(state.email, state.password);
      print(user);
      emit(state.copyWith(apiStatus: LoadedStatus(user)));
    }catch (exception){
      emit(state.copyWith(apiStatus: FailedStatus(exception.toString())));
    }
  }

  Future<void> emailChanged(String value) async {
    emit(state.copyWith(email: value));
  }

  Future<void> passwordChanged(String value) async {
    emit(state.copyWith(password: value));
  }
}
