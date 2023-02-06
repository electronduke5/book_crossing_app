part of 'author_cubit.dart';

class AuthorState {
  final ApiStatus<Author> addAuthorStatus;
  final ApiStatus<List<Author>> getAuthorsState;
  final String surname;
  final String name;
  final String? patronymic;

  AuthorState({
    this.addAuthorStatus = const IdleStatus(),
    this.getAuthorsState = const IdleStatus(),
    this.surname = '',
    this.name = '',
    this.patronymic = '',
  });

  AuthorState copyWith({
    ApiStatus<Author>? addAuthorStatus,
    ApiStatus<List<Author>>? getAuthorsState,
    String? surname,
    String? name,
    String? patronymic,
  }) =>
      AuthorState(
        surname: surname ?? this.surname,
        name: name ?? this.name,
        patronymic: patronymic ?? this.patronymic,
        addAuthorStatus: addAuthorStatus ?? this.addAuthorStatus,
        getAuthorsState: getAuthorsState ?? this.getAuthorsState,
      );
}
