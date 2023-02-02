part of 'profile_cubit.dart';

class ProfileState {
  final ApiStatus<User> status;

  ProfileState({
    this.status = const IdleStatus(),
  });

  ProfileState copyWith({
    ApiStatus<User>? status,
  }) =>
      ProfileState(
        status: status ?? this.status,
      );
}
