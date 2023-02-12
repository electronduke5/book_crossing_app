import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:flutter/src/material/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/preferenses_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  @override
  Future<void> removeSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
    prefs.remove('password');
  }

  @override
  Future<void> saveProfile(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login);
    prefs.setString('password', password);
  }

  @override
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login');
    final password = prefs.getString('password');
    print('login: $login');
    print('password: $password');

    if(login != null && password != null){
      final auth = AppModule.getAuthRepository();
      final user = await auth.signIn(login, password);
      AppModule.getProfileHolder().user = user;
      return user.name;
    }
    return null;
  }

  @override
  Future<void> saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', themeMode.index);
    print('themeMode save: ${themeMode.name}');
    print('theme in prefs ${ThemeMode.values[prefs.getInt('theme')!].name}');
  }

  @override
  Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.containsKey('theme'));
    if(prefs.containsKey('theme')){
      print(ThemeMode.values[prefs.getInt('theme')!].name);
      return ThemeMode.values[prefs.getInt('theme')!];
    }
    return ThemeMode.system;
  }
}
