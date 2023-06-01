import 'package:book_crossing_app/data/models/transfer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'book.dart';
import 'status.dart';

part '../../domain/models/user/user.freezed.dart';
part '../../domain/models/user/user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String surname,
    required String name,
    required String email,
    String? image,
    Status? status,
    Status? nextStatus,
    String? phoneNumber,
    int? activeTransfersCount,
    int? inactiveTransfersCount,
    List<Book>? ownerBooks,
    List<Book>? readerBooks,
    List<Transfer>? requests,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String getFullName() {
    return '$surname $name';
  }

  String getInitials(){
    return '${surname[0].toUpperCase()} ${name[0].toUpperCase()}';
  }
}
