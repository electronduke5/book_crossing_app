import '../../data/models/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile({User? user});

  Future<User> updateProfile({
    required String surname,
    required String name,
    String? email,
    String? image,
  });
}
