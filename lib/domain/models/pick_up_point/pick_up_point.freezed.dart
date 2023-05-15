// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../data/models/pick_up_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PickUpPoint _$PickUpPointFromJson(Map<String, dynamic> json) {
  return _PickUpPoint.fromJson(json);
}

/// @nodoc
mixin _$PickUpPoint {
  int get id => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get house => throw _privateConstructorUsedError;
  String? get flat => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PickUpPointCopyWith<PickUpPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickUpPointCopyWith<$Res> {
  factory $PickUpPointCopyWith(
          PickUpPoint value, $Res Function(PickUpPoint) then) =
      _$PickUpPointCopyWithImpl<$Res, PickUpPoint>;
  @useResult
  $Res call(
      {int id,
      String? city,
      String? street,
      String? house,
      String? flat,
      String? comment,
      User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$PickUpPointCopyWithImpl<$Res, $Val extends PickUpPoint>
    implements $PickUpPointCopyWith<$Res> {
  _$PickUpPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? city = freezed,
    Object? street = freezed,
    Object? house = freezed,
    Object? flat = freezed,
    Object? comment = freezed,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      house: freezed == house
          ? _value.house
          : house // ignore: cast_nullable_to_non_nullable
              as String?,
      flat: freezed == flat
          ? _value.flat
          : flat // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PickUpPointCopyWith<$Res>
    implements $PickUpPointCopyWith<$Res> {
  factory _$$_PickUpPointCopyWith(
          _$_PickUpPoint value, $Res Function(_$_PickUpPoint) then) =
      __$$_PickUpPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? city,
      String? street,
      String? house,
      String? flat,
      String? comment,
      User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_PickUpPointCopyWithImpl<$Res>
    extends _$PickUpPointCopyWithImpl<$Res, _$_PickUpPoint>
    implements _$$_PickUpPointCopyWith<$Res> {
  __$$_PickUpPointCopyWithImpl(
      _$_PickUpPoint _value, $Res Function(_$_PickUpPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? city = freezed,
    Object? street = freezed,
    Object? house = freezed,
    Object? flat = freezed,
    Object? comment = freezed,
    Object? user = null,
  }) {
    return _then(_$_PickUpPoint(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      house: freezed == house
          ? _value.house
          : house // ignore: cast_nullable_to_non_nullable
              as String?,
      flat: freezed == flat
          ? _value.flat
          : flat // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PickUpPoint implements _PickUpPoint {
  const _$_PickUpPoint(
      {required this.id,
      this.city,
      this.street,
      this.house,
      this.flat,
      this.comment,
      required this.user});

  factory _$_PickUpPoint.fromJson(Map<String, dynamic> json) =>
      _$$_PickUpPointFromJson(json);

  @override
  final int id;
  @override
  final String? city;
  @override
  final String? street;
  @override
  final String? house;
  @override
  final String? flat;
  @override
  final String? comment;
  @override
  final User user;

  @override
  String toString() {
    return 'PickUpPoint(id: $id, city: $city, street: $street, house: $house, flat: $flat, comment: $comment, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PickUpPoint &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.house, house) || other.house == house) &&
            (identical(other.flat, flat) || other.flat == flat) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, city, street, house, flat, comment, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PickUpPointCopyWith<_$_PickUpPoint> get copyWith =>
      __$$_PickUpPointCopyWithImpl<_$_PickUpPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PickUpPointToJson(
      this,
    );
  }

  @override
  String _getValue(String? value, {String? prefix, bool last = false}) {
    if (value == null) {
      return '';
    }
    if (prefix == null) return '$value${last? '' : ','}';
    return '$prefix. $value${last? '' : ','}';
  }

  @override
  String getPoint() {
    return '${_getValue(city)} ${_getValue(street)} ${_getValue(
        house, prefix: 'д')} ${_getValue(flat, prefix: 'кв', last: true)}';
  }

  @override
  String getPointShort() {
    return '${_getValue(city)} ${_getValue(street,last: true)}';
  }
}

abstract class _PickUpPoint implements PickUpPoint {
  const factory _PickUpPoint(
      {required final int id,
      final String? city,
      final String? street,
      final String? house,
      final String? flat,
      final String? comment,
      required final User user}) = _$_PickUpPoint;

  factory _PickUpPoint.fromJson(Map<String, dynamic> json) =
      _$_PickUpPoint.fromJson;

  @override
  int get id;
  @override
  String? get city;
  @override
  String? get street;
  @override
  String? get house;
  @override
  String? get flat;
  @override
  String? get comment;
  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$_PickUpPointCopyWith<_$_PickUpPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
