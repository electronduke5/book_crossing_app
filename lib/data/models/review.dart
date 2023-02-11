import 'package:book_crossing_app/data/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import 'book.dart';

part '../../domain/models/review/review.freezed.dart';
 part '../../domain/models/review/review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required String title,
    required String text,
    required User user,
    required Book book,
    List<User>? likedUser,
    required int likesCount,
    required int bookRating,
    required DateTime dateCreated,
    required bool isArchived,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  String getDate(){
    return  DateFormat('dd.MM.yyyy').format(dateCreated);
  }
}
