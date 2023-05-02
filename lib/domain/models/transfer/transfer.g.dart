// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transfer _$$_TransferFromJson(Map<String, dynamic> json) => _$_Transfer(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      point: PickUpPoint.fromJson(json['point'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TransferToJson(_$_Transfer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'book': instance.book,
      'point': instance.point,
    };
