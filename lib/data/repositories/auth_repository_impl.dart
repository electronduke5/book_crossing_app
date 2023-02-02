import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/auth_repository.dart';
import '../api_service.dart';

class AuthRepositoryImpl with ApiService<User> implements AuthRepository {
  @override
  String apiRoute = ApiConstUrl.loginUrl;

  @override
  Future<User> signIn(String email, String password) => post(
        fromJson: (Map<String, dynamic> json) => User.fromJson(json),
        data: {'email': email, 'password': password},
      );

  @override
  Future<User> signUp(
      String surname, String name, String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
