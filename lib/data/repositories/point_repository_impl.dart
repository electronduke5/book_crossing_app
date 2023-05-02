import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:book_crossing_app/domain/repositories/point_repository.dart';

import '../models/pick_up_point.dart';

class PointRepositoryImpl with ApiService<PickUpPoint> implements PointRepository {
  @override
  String apiRoute = ApiConstUrl.pointUrl;

  @override
  Future<PickUpPoint> createPoint({required String city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    required User user}) {
    return post(
      fromJson: (Map<String, dynamic> json) => PickUpPoint.fromJson(json),
      data: {
        'city': city,
        'street': street,
        'house': house,
        'flat': flat,
        'comment': comment,
        'user_id': user.id,
      },
    );
  }

  @override
  Future<void> deletePoint(int id) {
    return delete(id);
  }

  @override
  Future<List<PickUpPoint>> getAllPoints() {
    return getAll(fromJson: (Map<String, dynamic> json) => PickUpPoint.fromJson(json));
  }

  @override
  Future<List<PickUpPoint>> getUserPoints(User user) {
    return getAll(
      fromJson: (Map<String, dynamic> json) => PickUpPoint.fromJson(json),
      params: {'user': user.id},
    );
  }

  @override
  Future<PickUpPoint> updatePoint({required int pointId,
    String? city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    User? user,}) {
    return put(
        fromJson: (Map<String, dynamic> json) => PickUpPoint.fromJson(json),
        data: {
          'city': city,
          'street': street,
          'house': house,
          'flat': flat,
          'comment': comment,
          'user_id': user?.id,
        },
        id: pointId,
    );
  }
}
