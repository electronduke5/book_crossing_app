import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/review.dart';
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
}
