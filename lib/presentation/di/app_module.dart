import 'package:book_crossing_app/data/repositories/profile_repository_impl.dart';
import 'package:book_crossing_app/data/repositories/review_repository_impl.dart';
import 'package:book_crossing_app/domain/repositories/profile_repository.dart';
import 'package:book_crossing_app/domain/repositories/review_repository.dart';
import 'package:book_crossing_app/presentation/di/profile_holder.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/prefs_respository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/preferenses_repository.dart';

class AppModule {
  static bool _provided = false;

  void provideDependencies() {
    if (_provided) return;
    _provideProfileHolder();
    _provideAuthRepository();
    _providePreferencesRepository();
    _provideProfileRepository();
    _provideReviewRepository();

    _provided = true;
  }

  void _provideProfileHolder() {
    GetIt.instance.registerSingleton(ProfileHolder());
  }

  static ProfileHolder getProfileHolder() {
    return GetIt.instance.get<ProfileHolder>();
  }

  void _provideProfileRepository() {
    GetIt.instance.registerSingleton(ProfileRepositoryImpl());
  }

  static ProfileRepository getProfileRepository() {
    return GetIt.instance.get<ProfileRepositoryImpl>();
  }

  void _provideReviewRepository() {
    GetIt.instance.registerSingleton(ReviewRepositoryImpl());
  }

  static ReviewRepository getReviewRepository() {
    return GetIt.instance.get<ReviewRepositoryImpl>();
  }

  void _provideAuthRepository() {
    GetIt.instance.registerSingleton(AuthRepositoryImpl());
  }

  static AuthRepository getAuthRepository() {
    return GetIt.instance.get<AuthRepositoryImpl>();
  }

  void _providePreferencesRepository() {
    GetIt.instance.registerSingleton(PreferencesRepositoryImpl());
  }

  static PreferencesRepository getPreferencesRepository() {
    if (!_provided) throw Exception("Value not provided");
    return GetIt.instance.get<PreferencesRepositoryImpl>();
  }
}
