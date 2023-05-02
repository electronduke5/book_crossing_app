import 'package:book_crossing_app/data/models/pick_up_point.dart';

import '../../data/models/user.dart';

abstract class PointRepository {
  Future<List<PickUpPoint>> getAllPoints();

  Future<List<PickUpPoint>> getUserPoints(User user);

  Future<void> deletePoint(int id);

  Future<PickUpPoint> createPoint({
    required String city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    required User user,
  });

  Future<PickUpPoint> updatePoint({
    required int pointId,
    String? city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    User? user,
  });
}
