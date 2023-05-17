// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transfer _$$_TransferFromJson(Map<String, dynamic> json) => _$_Transfer(
      id: json['id'] as int,
      isActive: (json['isActive'] as int) == 1 ? true : false,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      point: PickUpPoint.fromJson(json['point'] as Map<String, dynamic>),
      recipients: (json['recipients'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$$_TransferToJson(_$_Transfer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isActive': instance.isActive,
      'user': instance.user,
      'book': instance.book,
      'point': instance.point,
      'recipients': instance.recipients,
      'dateCreated': instance.dateCreated.toIso8601String(),
    };
