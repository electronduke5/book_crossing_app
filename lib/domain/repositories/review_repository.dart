import '../../data/models/book.dart';
import '../../data/models/review.dart';
import '../../data/models/user.dart';

abstract class ReviewRepository {
  Future<List<Review>> getUsersReview({required int id, int? isArchive});

  Future<List<Review>> getAllReviews({String? filter, dynamic value});

  Future<Review> addReview(
      String title, String text, Book book, int rating, User user);

  Future<Review> archiveReview(int id);

  Future<Review> unzipReview(int id);

  Future<void> deleteReview(int id);
}
