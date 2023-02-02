abstract class PreferencesRepository{
  Future<String?> getUser();

  Future<void> saveProfile(String login, String password);

  Future<void> removeSavedProfile();
}