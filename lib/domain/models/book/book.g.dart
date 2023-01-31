// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      genre: Genre.fromJson(json['genre'] as Map<String, dynamic>),
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      reader: User.fromJson(json['reader'] as Map<String, dynamic>),
      likedUser: (json['likedUser'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'rating': instance.rating,
      'author': instance.author,
      'genre': instance.genre,
      'owner': instance.owner,
      'reader': instance.reader,
      'likedUser': instance.likedUser,
    };
