// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../data/models/review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  Book get book => throw _privateConstructorUsedError;
  List<User>? get likedUser => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  int get bookRating => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {int id,
      String title,
      String text,
      User user,
      Book book,
      List<User>? likedUser,
      int likesCount,
      int bookRating,
      DateTime dateCreated});

  $UserCopyWith<$Res> get user;
  $BookCopyWith<$Res> get book;
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? user = null,
    Object? book = null,
    Object? likedUser = freezed,
    Object? likesCount = null,
    Object? bookRating = null,
    Object? dateCreated = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as Book,
      likedUser: freezed == likedUser
          ? _value.likedUser
          : likedUser // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookRating: null == bookRating
          ? _value.bookRating
          : bookRating // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BookCopyWith<$Res> get book {
    return $BookCopyWith<$Res>(_value.book, (value) {
      return _then(_value.copyWith(book: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$_ReviewCopyWith(_$_Review value, $Res Function(_$_Review) then) =
      __$$_ReviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String text,
      User user,
      Book book,
      List<User>? likedUser,
      int likesCount,
      int bookRating,
      DateTime dateCreated});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $BookCopyWith<$Res> get book;
}

/// @nodoc
class __$$_ReviewCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$_Review>
    implements _$$_ReviewCopyWith<$Res> {
  __$$_ReviewCopyWithImpl(_$_Review _value, $Res Function(_$_Review) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? user = null,
    Object? book = null,
    Object? likedUser = freezed,
    Object? likesCount = null,
    Object? bookRating = null,
    Object? dateCreated = null,
  }) {
    return _then(_$_Review(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as Book,
      likedUser: freezed == likedUser
          ? _value._likedUser
          : likedUser // ignore: cast_nullable_to_non_nullable
              as List<User>?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookRating: null == bookRating
          ? _value.bookRating
          : bookRating // ignore: cast_nullable_to_non_nullable
              as int,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Review implements _Review {
  const _$_Review(
      {required this.id,
      required this.title,
      required this.text,
      required this.user,
      required this.book,
      final List<User>? likedUser,
      required this.likesCount,
      required this.bookRating,
      required this.dateCreated})
      : _likedUser = likedUser;

  factory _$_Review.fromJson(Map<String, dynamic> json) =>
      _$$_ReviewFromJson(json);
  String getDate(){
    return  DateFormat('dd.MM.yyyy').format(dateCreated);
  }

  @override
  final int id;
  @override
  final String title;
  @override
  final String text;
  @override
  final User user;
  @override
  final Book book;
  final List<User>? _likedUser;
  @override
  List<User>? get likedUser {
    final value = _likedUser;
    if (value == null) return null;
    if (_likedUser is EqualUnmodifiableListView) return _likedUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int likesCount;
  @override
  final int bookRating;
  @override
  final DateTime dateCreated;

  @override
  String toString() {
    return 'Review(id: $id, title: $title, text: $text, user: $user, book: $book, likedUser: $likedUser, likesCount: $likesCount, bookRating: $bookRating, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Review &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.book, book) || other.book == book) &&
            const DeepCollectionEquality()
                .equals(other._likedUser, _likedUser) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.bookRating, bookRating) ||
                other.bookRating == bookRating) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      text,
      user,
      book,
      const DeepCollectionEquality().hash(_likedUser),
      likesCount,
      bookRating,
      dateCreated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewCopyWith<_$_Review> get copyWith =>
      __$$_ReviewCopyWithImpl<_$_Review>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReviewToJson(
      this,
    );
  }
}

abstract class _Review implements Review {
  const factory _Review(
      {required final int id,
      required final String title,
      required final String text,
      required final User user,
      required final Book book,
      final List<User>? likedUser,
      required final int likesCount,
      required final int bookRating,
      required final DateTime dateCreated}) = _$_Review;

  factory _Review.fromJson(Map<String, dynamic> json) = _$_Review.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get text;
  @override
  User get user;
  @override
  Book get book;
  @override
  List<User>? get likedUser;
  @override
  int get likesCount;
  @override
  int get bookRating;
  @override
  DateTime get dateCreated;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewCopyWith<_$_Review> get copyWith =>
      throw _privateConstructorUsedError;
}
