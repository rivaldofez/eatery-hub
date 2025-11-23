import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  Future<void> saveStringValue(String key, String value) async {
    try {
      await _preferences.setString(key, value);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value");
    }
  }

  String getStringValue(String key) {
    return _preferences.getString(key) ?? "";
  }
}
