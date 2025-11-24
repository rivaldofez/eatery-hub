import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  Future<void> saveStringValue(String key, String value) async {
    try {
      await _preferences.setString(key, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the string value");
    }
  }

  Future<void> saveBoolValue(String key, bool value) async {
    try {
      await _preferences.setBool(key, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the bool value");
    }
  }

  String getStringValue(String key) {
    return _preferences.getString(key) ?? "";
  }

  bool? getBoolValue(String key) {
    return _preferences.getBool(key);
  }
}
