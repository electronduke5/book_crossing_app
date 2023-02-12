import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<User> signIn(
    String email,
    String password,
  );

  Future<User> signUp({
    required String surname,
    required String name,
    required String email,
    required String password,
  });
}
