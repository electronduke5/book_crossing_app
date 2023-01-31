import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<User> signIn(
    String email,
    String password,
  );

  Future<User> signUp(
    String surname,
    String name,
    String email,
    String password,
  );
}
