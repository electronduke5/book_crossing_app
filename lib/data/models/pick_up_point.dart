import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part '../../domain/models/pick_up_point/pick_up_point.freezed.dart';
part '../../domain/models/pick_up_point/pick_up_point.g.dart';

@freezed
class PickUpPoint with _$PickUpPoint {
  const factory PickUpPoint({
    required int id,
    String? city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    required User user,
  }) = _PickUpPoint;

  factory PickUpPoint.fromJson(Map<String, dynamic> json) => _$PickUpPointFromJson(json);

  String getPoint() {
    return '${_getValue(city)} ${_getValue(street)} ${_getValue(
        house, prefix: 'д')} ${_getValue(flat, prefix: 'кв', last: true)}';
  }

  String getPointShort() {
    return '${_getValue(city)} ${_getValue(street,last: true)}';
  }

  String _getValue(String? value, {String? prefix, bool last = false,}) {
    if (value == null) {
      return '';
    }
    if (prefix == null) return '$value${last? '' : ','}';
    return '$prefix. $value${last? '' : ','}';
  }
}
