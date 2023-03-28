import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/liked_repository.dart';
import '../api_service.dart';
import '../models/review.dart';
import '../models/user.dart';

class LikeRepositoryImpl with ApiService<Review> implements LikeRepository {
  @override
  Future<Review> likeReview({required Review review, required User user}) async {
    return post(fromJson: (Map<String, dynamic> json) => Review.fromJson(json), data: {
      'user_id': user.id,
      'review_id': review.id,
    });
  }

  @override
  String apiRoute = ApiConstUrl.likeUrl;
}
