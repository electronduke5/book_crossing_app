// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../data/models/user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get surname => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  Status? get status => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  List<Book>? get ownerBooks => throw _privateConstructorUsedError;
  List<Book>? get readerBooks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String surname,
      String name,
      String email,
      String? image,
      Status? status,
      String? phoneNumber,
      List<Book>? ownerBooks,
      List<Book>? readerBooks});

  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? surname = null,
    Object? name = null,
    Object? email = null,
    Object? image = freezed,
    Object? status = freezed,
    Object? phoneNumber = freezed,
    Object? ownerBooks = freezed,
    Object? readerBooks = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerBooks: freezed == ownerBooks
          ? _value.ownerBooks
          : ownerBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>?,
      readerBooks: freezed == readerBooks
          ? _value.readerBooks
          : readerBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String surname,
      String name,
      String email,
      String? image,
      Status? status,
      String? phoneNumber,
      List<Book>? ownerBooks,
      List<Book>? readerBooks});

  @override
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? surname = null,
    Object? name = null,
    Object? email = null,
    Object? image = freezed,
    Object? status = freezed,
    Object? phoneNumber = freezed,
    Object? ownerBooks = freezed,
    Object? readerBooks = freezed,
  }) {
    return _then(_$_User(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerBooks: freezed == ownerBooks
          ? _value._ownerBooks
          : ownerBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>?,
      readerBooks: freezed == readerBooks
          ? _value._readerBooks
          : readerBooks // ignore: cast_nullable_to_non_nullable
              as List<Book>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(
      {required this.id,
      required this.surname,
      required this.name,
      required this.email,
      this.image,
      this.status,
      this.phoneNumber,
      final List<Book>? ownerBooks,
      final List<Book>? readerBooks})
      : _ownerBooks = ownerBooks,
        _readerBooks = readerBooks;

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final int id;
  @override
  final String surname;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? image;
  @override
  final Status? status;
  @override
  final String? phoneNumber;
  final List<Book>? _ownerBooks;
  @override
  List<Book>? get ownerBooks {
    final value = _ownerBooks;
    if (value == null) return null;
    if (_ownerBooks is EqualUnmodifiableListView) return _ownerBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Book>? _readerBooks;
  @override
  List<Book>? get readerBooks {
    final value = _readerBooks;
    if (value == null) return null;
    if (_readerBooks is EqualUnmodifiableListView) return _readerBooks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(id: $id, surname: $surname, name: $name, email: $email, image: $image, status: $status, phoneNumber: $phoneNumber, ownerBooks: $ownerBooks, readerBooks: $readerBooks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality()
                .equals(other._ownerBooks, _ownerBooks) &&
            const DeepCollectionEquality()
                .equals(other._readerBooks, _readerBooks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      surname,
      name,
      email,
      image,
      status,
      phoneNumber,
      const DeepCollectionEquality().hash(_ownerBooks),
      const DeepCollectionEquality().hash(_readerBooks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }

  @override
  String getFullName() {
    return '$surname $name';
  }

  @override
  String getInitials() {
    return '${surname[0].toUpperCase()} ${name[0].toUpperCase()}';
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String surname,
      required final String name,
      required final String email,
      final String? image,
      final Status? status,
      final String? phoneNumber,
      final List<Book>? ownerBooks,
      final List<Book>? readerBooks}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  int get id;
  @override
  String get surname;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get image;
  @override
  Status? get status;
  @override
  String? get phoneNumber;
  @override
  List<Book>? get ownerBooks;
  @override
  List<Book>? get readerBooks;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
