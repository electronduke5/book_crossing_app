// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/pick_up_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PickUpPoint _$$_PickUpPointFromJson(Map<String, dynamic> json) =>
    _$_PickUpPoint(
      id: json['id'] as int,
      city: json['city'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      flat: json['flat'] as String?,
      comment: json['comment'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PickUpPointToJson(_$_PickUpPoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
      'flat': instance.flat,
      'comment': instance.comment,
      'user': instance.user,
    };
