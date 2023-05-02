import 'dart:io';

import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/profile_repository.dart';
import '../api_service.dart';
import '../utils/api_const_url.dart';

class ProfileRepositoryImpl with ApiService<User> implements ProfileRepository {
  @override
  String apiRoute = ApiConstUrl.userUrl;

  @override
  Future<User> getProfile({User? user}) async {
    final User receivedUser = user == null
        ? AppModule.getProfileHolder().user
        : await get(
            fromJson: (Map<String, dynamic> json) => User.fromJson(json),
            id: user.id);
    print('User from AppModule: ${AppModule.getProfileHolder().user}');
    return receivedUser;
  }

  @override
  Future<User> updateProfile({
    String? surname,
    String? name,
    String? email,
    String? phoneNumber,
    File? image,
  }) async {
    return put(
      fromJson: (Map<String, dynamic> json) => User.fromJson(json),
      data: {
        'surname': surname,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'image': image == null ? null : await MultipartFile.fromFile(image.path),
      },
      id: AppModule.getProfileHolder().user.id,
    );
  }

  @override
  Future<User> removeImage(int id) {
    return post(
      fromJson: (Map<String, dynamic> json) => User.fromJson(json),
      data: {},
      id: 'removeImage/$id',
    );
  }
}
