import '../../data/models/review.dart';
import '../../data/models/user.dart';

abstract class ProfileRepository {
  Future<List<Review>> getUsersReview(int id);
  Future<User> getProfile();
}
