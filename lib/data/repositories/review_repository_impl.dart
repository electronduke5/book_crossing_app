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
  Future<List<Review>> getUsersReview({required int id, int? isArchive}) {
    return getAll(
      fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
      params: {'user': id, 'archive': isArchive},
    );
  }

  @override
  Future<List<Review>> getAllReviews({String? filter, dynamic value}) => getAll(
    fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
        params: {filter ?? '': value},
      );

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

  @override
  Future<Review> archiveReview(int id) {
    return post(
        fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
        id: 'archive/$id',
        data: {});
  }

  @override
  Future<Review> unzipReview(int id) {
    return post(
      fromJson: (Map<String, dynamic> json) => Review.fromJson(json),
      id: 'unzip/$id',
      data: {},
    );
  }

  @override
  Future<void> deleteReview(int id) {
    return delete(id);
  }
}
