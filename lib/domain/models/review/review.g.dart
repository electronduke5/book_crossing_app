// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Review _$$_ReviewFromJson(Map<String, dynamic> json) => _$_Review(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      likedUser: (json['likedUser'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      likesCount: json['likesCount'] as int,
      bookRating: json['bookRating'] as int,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      isArchived: (json['isArchived'] as int) == 1 ? true : false,
    );

Map<String, dynamic> _$$_ReviewToJson(_$_Review instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'user': instance.user,
      'book': instance.book,
      'likedUser': instance.likedUser,
      'likesCount': instance.likesCount,
      'bookRating': instance.bookRating,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'isArchived': instance.isArchived,
    };
