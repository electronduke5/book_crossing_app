import 'package:freezed_annotation/freezed_annotation.dart';

part '../../domain/models/author/author.freezed.dart';
part '../../domain/models/author/author.g.dart';

@freezed
class Author with _$Author {
  const factory Author({
    required int id,
    required String surname,
    required String name,
    required String patronymic,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  String getFullName() => '$surname $name $patronymic';

  String getSurnameName() => '$surname $name';

  String getInitials() {
    return patronymic == null
        ? '${name[0]}. $surname'
        : '${name[0]}. ${patronymic[0]}. $surname';
  }
}
