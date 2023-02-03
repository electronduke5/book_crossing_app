import '../../data/models/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getUsersReview(int id);

  Future<List<Review>> getAllReviews();
}
