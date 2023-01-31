part of 'auth_cubit.dart';

class AuthState {
  final String password;
  final String email;
  final ApiStatus<User> apiStatus;

  AuthState({
    this.apiStatus = const IdleStatus(),
    this.password = '',
    this.email = '',
  });

  AuthState copyWith({
    String? password,
    String? email,
    ApiStatus<User>? apiStatus,
  }) =>
      AuthState(
        password: password ?? this.password,
        email: email ?? this.email,
        apiStatus: apiStatus ?? this.apiStatus,
      );
}

