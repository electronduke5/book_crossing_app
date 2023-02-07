import 'package:book_crossing_app/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'author.dart';
import 'genre.dart';

part '../../domain/models/book/book.freezed.dart';
part '../../domain/models/book/book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required int id,
    required String title,
    required int reviewsCount,
    String? description,
    String? image,
    double? rating ,
    required Author author,
    required Genre genre,
    required User owner,
    required User reader,
    required List<User>? likedUser,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
