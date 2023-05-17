// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/models/status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Status _$$_StatusFromJson(Map<String, dynamic> json) => _$_Status(
      id: json['id'] as int,
      status: json['status'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$$_StatusToJson(_$_Status instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'count': instance.count,
    };
