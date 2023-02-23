import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../domain/repositories/profile_repository.dart';
import '../api_service.dart';
import '../utils/api_const_url.dart';

class ProfileRepositoryImpl with ApiService<User> implements ProfileRepository {
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
    required String surname,
    required String name,
    String? email,
    String? image,
  }) async {
    return put(
      fromJson: (Map<String, dynamic> json) => User.fromJson(json),
      data: {
        'surname': surname,
        'name': name,
        'email': email,
        'image': image,
      },
      id: AppModule.getProfileHolder().user.id,
    );
  }

  @override
  String apiRoute = ApiConstUrl.userUrl;
}
