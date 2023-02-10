import '../../data/models/review.dart';
import '../../data/models/user.dart';

abstract class LikeRepository {
 Future<Review> likeReview({required Review review, required User user});
}