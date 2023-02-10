import 'dart:developer';
import 'dart:io';

import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/liked_repository.dart';
import '../models/review.dart';
import '../models/user.dart';

class LikeRepositoryImpl implements LikeRepository {
  @override
  Future<Review> likeReview({required Review review, required User user}) async {
    final dio = Dio(
      BaseOptions(
        headers: {"Accept": "application/json"},
        validateStatus: (status) => true,
      ),
    );

    try {
      final response = await dio.post(
        '${ApiConstUrl.baseUrl}${ApiConstUrl.likeUrl}',
        data: {
          'user_id': user.id,
          'review_id': review.id,
        },
      );
      log('response.statusCode: ${response.statusCode}');

      if (response.statusCode != HttpStatus.ok) {
        throw Exception(['Error =_-']);
      }
      return Review.fromJson(response.data);
    } catch (error) {
      print(error.toString());
      throw Exception(error);
    }
  }
}
