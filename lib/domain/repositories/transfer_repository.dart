import 'package:book_crossing_app/data/models/pick_up_point.dart';

import '../../data/models/book.dart';
import '../../data/models/transfer.dart';
import '../../data/models/user.dart';

abstract class TransferRepository {

  Future<List<Transfer>> getAllTransfers();

  Future<List<Transfer>> getUserTransfers(User user);

  Future<List<Transfer>> getBookTransfers(Book book);

  Future<Transfer> createTransfer({
    required User user,
    required Book book,
    required PickUpPoint pickUpPoint,
  });
}
