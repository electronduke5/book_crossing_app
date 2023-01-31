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
}
