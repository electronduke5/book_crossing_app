import 'package:freezed_annotation/freezed_annotation.dart';

part '../../domain/models/genre/genre.freezed.dart';
part '../../domain/models/genre/genre.g.dart';

@freezed
class Genre with _$Genre {
  const factory Genre({
    required int id,
    required String genreName,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
