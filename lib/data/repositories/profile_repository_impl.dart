import 'package:book_crossing_app/data/models/review.dart';

import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  @override
  Future<User> getProfile() async {
    final user = AppModule.getProfileHolder().user;
    return user;
  }

  @override
  Future<List<Review>> getUsersReview(int id) {
    // TODO: implement getUsersReview
    throw UnimplementedError();
  }

}