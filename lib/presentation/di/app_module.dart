import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';


class AppModule{
  static bool _provided = false;
  void provideDependencies(){
    if(_provided) return;

    _provideAuthRepository();

    _provided = true;
  }

  void _provideAuthRepository() {
    GetIt.instance.registerSingleton(AuthRepositoryImpl());
  }

  static AuthRepository getAuthRepository() {
    return GetIt.instance.get<AuthRepositoryImpl>();
  }
}