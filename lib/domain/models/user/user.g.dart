// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int,
      surname: json['surname'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      ownerBooks: (json['ownerBooks'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      readerBooks: (json['readerBooks'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'surname': instance.surname,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'status': instance.status,
      'phoneNumber': instance.phoneNumber,
      'ownerBooks': instance.ownerBooks,
      'readerBooks': instance.readerBooks,
    };
