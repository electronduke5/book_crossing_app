import 'package:book_crossing_app/data/repositories/auhor_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/book_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/genres_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/point_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/profile_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/review_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/status_repository_impl.dart';
import 'package:book_crossing_app/domain/repositories/author_repository.dart';
import 'package:book_crossing_app/domain/repositories/book_repository.dart';
import 'package:book_crossing_app/domain/repositories/genre_repository.dart';
import 'package:book_crossing_app/domain/repositories/profile_repository.dart';
import 'package:book_crossing_app/domain/repositories/review_repository.dart';
import 'package:book_crossing_app/presentation/di/profile_holder.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/liked_repository_impl.dart';
import '../../data/repositories/prefs_respository_impl.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/liked_repository.dart';
import '../../domain/repositories/point_repository.dart';
import '../../domain/repositories/preferenses_repository.dart';
import '../../domain/repositories/status_repository.dart';
import '../../domain/repositories/transfer_repository.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;
    _provideProfileHolder();
    _provideAuthRepository();
    _providePreferencesRepository();
    _provideProfileRepository();
    _provideReviewRepository();
    _provideBookRepository();
    _provideAuthorRepository();
    _provideGenreRepository();
    _provideLikeRepository();
    _provideStatusRepository();
    _providePointRepository();
    _provideTransferRepository();

    _provided = true;
  }

  void _provideProfileHolder() {
    GetIt.instance.registerSingleton(ProfileHolder());
  }

  static ProfileHolder getProfileHolder() {
    return GetIt.instance.get<ProfileHolder>();
  }

  void _provideLikeRepository() {
    GetIt.instance.registerSingleton(LikeRepositoryImpl());
  }

  static LikeRepository getLikeRepository() {
    return GetIt.instance.get<LikeRepositoryImpl>();
  }

  void _provideProfileRepository() {
    GetIt.instance.registerSingleton(ProfileRepositoryImpl());
  }

  static ProfileRepository getProfileRepository() {
    return GetIt.instance.get<ProfileRepositoryImpl>();
  }

  void _provideAuthorRepository() {
    GetIt.instance.registerSingleton(AuthorRepositoryImpl());
  }

  static AuthorRepository getAuthorRepository() {
    return GetIt.instance.get<AuthorRepositoryImpl>();
  }

  void _provideGenreRepository() {
    GetIt.instance.registerSingleton(GenreRepositoryImpl());
  }

  static GenreRepository getGenreRepository() {
    return GetIt.instance.get<GenreRepositoryImpl>();
  }

  void _provideReviewRepository() {
    GetIt.instance.registerSingleton(ReviewRepositoryImpl());
  }

  static ReviewRepository getReviewRepository() {
    return GetIt.instance.get<ReviewRepositoryImpl>();
  }

  void _provideBookRepository() {
    GetIt.instance.registerSingleton(BookRepositoryImpl());
  }

  static BookRepository getBookRepository() {
    return GetIt.instance.get<BookRepositoryImpl>();
  }

  void _provideAuthRepository() {
    GetIt.instance.registerSingleton(AuthRepositoryImpl());
  }

  static AuthRepository getAuthRepository() {
    return GetIt.instance.get<AuthRepositoryImpl>();
  }

  void _provideStatusRepository() {
    GetIt.instance.registerSingleton(StatusRepositoryImpl());
  }

  static StatusRepository getStatusRepository() {
    return GetIt.instance.get<StatusRepositoryImpl>();
  }

  void _providePointRepository() {
    GetIt.instance.registerSingleton(PointRepositoryImpl());
  }

  static PointRepository getPointRepository() {
    return GetIt.instance.get<PointRepositoryImpl>();
  }

  void _provideTransferRepository() {
    GetIt.instance.registerSingleton(TransferRepositoryImpl());
  }

  static TransferRepository getTransferRepository() {
    return GetIt.instance.get<TransferRepositoryImpl>();
  }

  void _providePreferencesRepository() {
    GetIt.instance.registerSingleton(PreferencesRepositoryImpl());
  }

  static PreferencesRepository getPreferencesRepository() {
    if (!_provided) throw Exception("Value not provided");
    return GetIt.instance.get<PreferencesRepositoryImpl>();
  }
}
