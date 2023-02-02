import 'package:freezed_annotation/freezed_annotation.dart';

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
    //required String password,
    //String? refreshToken
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String getFullName() {
    return '$surname $name';
  }

  String getInitials(){
    return '${surname[0].toUpperCase()} ${name[0].toUpperCase()}';
  }
}
