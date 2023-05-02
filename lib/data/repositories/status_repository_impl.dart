import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';

import '../../domain/repositories/status_repository.dart';
import '../models/status.dart';

class StatusRepositoryImpl with ApiService<Status> implements StatusRepository {
  @override
  Future<List<Status>> getAllStatuses() {
    return getAll(fromJson: (Map<String, dynamic> json) => Status.fromJson(json));
  }

  @override
  String apiRoute = ApiConstUrl.statusUrl;
}
