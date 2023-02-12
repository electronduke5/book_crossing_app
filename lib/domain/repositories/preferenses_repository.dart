import 'package:flutter/material.dart';

abstract class PreferencesRepository{
  Future<String?> getUser();

  Future<void> saveProfile(String login, String password);

  Future<void> saveTheme(ThemeMode themeMode);

  Future<ThemeMode> loadThemeMode();

  Future<void> removeSavedProfile();
}