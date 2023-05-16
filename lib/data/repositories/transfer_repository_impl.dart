import 'package:book_crossing_app/data/api_service.dart';
import 'package:book_crossing_app/data/models/book.dart';
import 'package:book_crossing_app/data/models/pick_up_point.dart';
import 'package:book_crossing_app/data/models/transfer.dart';
import 'package:book_crossing_app/data/models/user.dart';
import 'package:book_crossing_app/data/utils/api_const_url.dart';
import 'package:book_crossing_app/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl with ApiService<Transfer> implements TransferRepository {
  @override
  String apiRoute = ApiConstUrl.transferUrl;

  @override
  Future<Transfer> createTransfer({
    required User user,
    required Book book,
    required PickUpPoint pickUpPoint,
  }) {
    return post(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      data: {
        'user_id': user.id,
        'book_id': book.id,
        'point_id': pickUpPoint.id,
      },
    );
  }

  @override
  Future<List<Transfer>> getBookTransfers(Book book) {
    return getAll(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      params: {'book': book.id},
    );
  }

  @override
  Future<List<Transfer>> getUserTransfers(User user, {bool isActive = true}) {
    return getAll(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      params: {'user': user.id, 'active' : isActive ? 'true' : 'false' ,},
    );
  }

  @override
  Future<List<Transfer>> getAllTransfers() {
    return getAll(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
    );
  }

  @override
  Future<Transfer> makeRequest({required User user, required Transfer transfer}) {
    return post(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      data: {
        'user_id': user.id,
        'transfer_id': transfer.id,
      },
      id: 'makeRequest/',
    );
  }

  @override
  Future<Transfer> makeTransfer({required User user, required Transfer transfer}) {
    return post(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      data: {
        'user_id': user.id,
        'transfer_id': transfer.id,
      },
      id: 'makeTransfer/',
    );
  }

  @override
  Future<Transfer> getTransfers(Transfer transfer) {
    return get(
      fromJson: (Map<String, dynamic> json) => Transfer.fromJson(json),
      id: transfer.id,
    );
  }
}
