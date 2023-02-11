// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../data/models/book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get reviewsCount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  Author get author => throw _privateConstructorUsedError;
  Genre get genre => throw _privateConstructorUsedError;
  User get owner => throw _privateConstructorUsedError;
  User get reader => throw _privateConstructorUsedError;
  List<User>? get likedUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {int id,
      String title,
      int reviewsCount,
      String? description,
      String? image,
      double? rating,
      Author author,
      Genre genre,
      User owner,
      User reader,
      List<User>? likedUser});

  $AuthorCopyWith<$Res> get author;
  $GenreCopyWith<$Res> get genre;
  $UserCopyWith<$Res> get owner;
  $UserCopyWith<$Res> get reader;
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? reviewsCount = null,
    Object? description = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? author = null,
    Object? genre = null,
    Object? owner = null,
    Object? reader = null,
    Object? likedUser = freezed,
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
      reviewsCount: null == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as Genre,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      reader: null == reader
          ? _value.reader
          : reader // ignore: cast_nullable_to_non_nullable
              as User,
      likedUser: freezed == likedUser
          ? _value.likedUser
          : likedUser // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthorCopyWith<$Res> get author {
    return $AuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GenreCopyWith<$Res> get genre {
    return $GenreCopyWith<$Res>(_value.genre, (value) {
      return _then(_value.copyWith(genre: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get owner {
    return $UserCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get reader {
    return $UserCopyWith<$Res>(_value.reader, (value) {
      return _then(_value.copyWith(reader: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      int reviewsCount,
      String? description,
      String? image,
      double? rating,
      Author author,
      Genre genre,
      User owner,
      User reader,
      List<User>? likedUser});

  @override
  $AuthorCopyWith<$Res> get author;
  @override
  $GenreCopyWith<$Res> get genre;
  @override
  $UserCopyWith<$Res> get owner;
  @override
  $UserCopyWith<$Res> get reader;
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? reviewsCount = null,
    Object? description = freezed,
    Object? image = freezed,
    Object? rating = freezed,
    Object? author = null,
    Object? genre = null,
    Object? owner = null,
    Object? reader = null,
    Object? likedUser = freezed,
  }) {
    return _then(_$_Book(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      reviewsCount: null == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
      genre: null == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as Genre,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      reader: null == reader
          ? _value.reader
          : reader // ignore: cast_nullable_to_non_nullable
              as User,
      likedUser: freezed == likedUser
          ? _value._likedUser
          : likedUser // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Book implements _Book {
  const _$_Book(
      {required this.id,
      required this.title,
      required this.reviewsCount,
      this.description,
      this.image,
      this.rating,
      required this.author,
      required this.genre,
      required this.owner,
      required this.reader,
      required final List<User>? likedUser})
      : _likedUser = likedUser;

  factory _$_Book.fromJson(Map<String, dynamic> json) => _$$_BookFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final int reviewsCount;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final double? rating;
  @override
  final Author author;
  @override
  final Genre genre;
  @override
  final User owner;
  @override
  final User reader;
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
  String toString() {
    return 'Book(id: $id, title: $title, reviewsCount: $reviewsCount, description: $description, image: $image, rating: $rating, author: $author, genre: $genre, owner: $owner, reader: $reader, likedUser: $likedUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.reviewsCount, reviewsCount) ||
                other.reviewsCount == reviewsCount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.reader, reader) || other.reader == reader) &&
            const DeepCollectionEquality()
                .equals(other._likedUser, _likedUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      reviewsCount,
      description,
      image,
      rating,
      author,
      genre,
      owner,
      reader,
      const DeepCollectionEquality().hash(_likedUser));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  const factory _Book(
      {required final int id,
      required final String title,
      required final int reviewsCount,
      final String? description,
      final String? image,
      final double? rating,
      required final Author author,
      required final Genre genre,
      required final User owner,
      required final User reader,
      required final List<User>? likedUser}) = _$_Book;

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  int get reviewsCount;
  @override
  String? get description;
  @override
  String? get image;
  @override
  double? get rating;
  @override
  Author get author;
  @override
  Genre get genre;
  @override
  User get owner;
  @override
  User get reader;
  @override
  List<User>? get likedUser;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
