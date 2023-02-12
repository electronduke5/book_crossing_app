import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/auth_repository.dart';
import '../api_service.dart';

class AuthRepositoryImpl with ApiService<User> implements AuthRepository {
  @override
  String apiRoute = ApiConstUrl.loginUrl;

  @override
  Future<User> signIn(String email, String password) {
    apiRoute = ApiConstUrl.loginUrl;
    return post(
      fromJson: (Map<String, dynamic> json) => User.fromJson(json),
      data: {'email': email, 'password': password},
    );
  }

  @override
  Future<User> signUp({
    required String surname,
    required String name,
    required String email,
    required String password,
  }) {
    apiRoute = ApiConstUrl.userUrl;
    return post(
      fromJson: (Map<String, dynamic> json) => User.fromJson(json),
      data: {
        'surname': surname,
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }
}
