import 'package:book_crossing_app/data/models/pick_up_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'book.dart';
import 'user.dart';

part '../../domain/models/transfer/transfer.freezed.dart';
part '../../domain/models/transfer/transfer.g.dart';

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    required int id,
    required bool isActive,
    required User user,
    required Book book,
    required PickUpPoint point,
    required List<User> recipients,
    required DateTime dateCreated,
  }) = _Transfer;

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);
}
