import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String getFullName() {
    return '$surname $name';
  }

  ///Метод получения инициалов пользователя в формате Фамилия Имя
  ///
  ///
  String getInitials(){
    return '${surname[0].toUpperCase()} ${name[0].toUpperCase()}';
  }
}
