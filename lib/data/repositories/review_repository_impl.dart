import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/book.dart';
import 'package:book_crossing_app/data/models/review.dart';
import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:book_crossing_app/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl with ApiService<Review> implements ReviewRepository {
  @override
  String apiRoute = ApiConstUrl.reviewUrl;

  @override
  Future<List<Review>> getUsersReview(int id) => getAll(
        fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
        qFilter: 'user',
        qFilterValue: id,
      );

  @override
  Future<List<Review>> getAllReviews({String? filter, dynamic value}) => getAll(
      fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
      qFilter: filter,
      qFilterValue: value);

  @override
  Future<Review> addReview(
      String title, String text, Book book, int rating, User user) {
    return post(
        fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
        data: {
          'title': title,
          'text': text,
          'book_id': book.id,
          'user_id': user.id,
          'book_rating': rating,
        });
  }
}
