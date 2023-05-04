import 'dart:io';

import '../../data/models/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile({User? user});
  Future<User> getProfileFromAPI({ required User user});
  Future<User> updateProfile({
    String? surname,
    String? name,
    String? email,
    String? phoneNumber,
    File? image,
  });

  Future<User> removeImage(int id);
}
