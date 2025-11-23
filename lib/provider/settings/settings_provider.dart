import 'package:eateryhub/data/local/shared_preferences_service.dart';
import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/data/model/theme_option.dart';
import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  static const _keyTheme = "KEY_THEME";

  SettingsProvider(this._service);

  String _message = "";
  String get message => _message;

  ThemeOption? _themeOption;
  ThemeOption? get themeOption => _themeOption;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> setThemeOption(ThemeOption option) async {
    try {
      await _service.saveStringValue(_keyTheme, option.value);
      _message = "Your theme is saved";
      _themeOption = option;
      notifyListeners();
    } catch (e) {
      _message = "Failed to save theme preferences";
      notifyListeners();
    }
  }

  void getThemeOption() {
    try {
      final result = _service.getStringValue(_keyTheme);
      _themeOption = ThemeOption.values.firstWhere(
        (item) => item.value == result,
        orElse: () => ThemeOption.system,
      );
      notifyListeners();
    } catch (e) {
      _message = "Failed to load theme preferences";
      notifyListeners();
    }
  }
}
