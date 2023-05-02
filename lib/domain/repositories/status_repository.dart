import 'package:book_crossing_app/data/models/status.dart';

abstract class StatusRepository {
  Future<List<Status>> getAllStatuses();
}
