import 'package:eateryhub/data/local/local_notification_service.dart';
import 'package:eateryhub/data/local/shared_preferences_service.dart';
import 'package:eateryhub/data/model/theme_option.dart';
import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferencesService _preferenceService;
  final LocalNotificationService _notificationService;

  static const _keyTheme = "KEY_THEME";
  static const _keyLunchNotification = "KEY_LUNCH_NOTIFICATION";

  SettingsProvider(this._preferenceService, this._notificationService);

  String _message = "";
  String get message => _message;

  ThemeOption? _themeOption;
  ThemeOption? get themeOption => _themeOption;

  bool? _isLunchNotificationEnabled;
  bool? get isLunchNotificationEnabled => _isLunchNotificationEnabled;

  final int _lunchNotificationId = 0;
  bool? _notificationPermission = false;
  bool? get notificationPermission => _notificationPermission;

  Future<void> requestNotificationPermission() async {
    _notificationPermission = await _notificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationService.cancelNotification(id);
  }

  void showLunchNotification() {
    _notificationService.scheduleDailyNotification(
      id: _lunchNotificationId,
      title: "Get Ready for Lunch",
      description:
          "Don't forget to have lunch, find your favorite restaurant for lunch",
      time: 11,
    );
  }

  Future<void> setThemeOption(ThemeOption option) async {
    try {
      await _preferenceService.saveStringValue(_keyTheme, option.value);
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
      final result = _preferenceService.getStringValue(_keyTheme);
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

  Future<void> toggleLunchNotification(bool state) async {
    try {
      await _preferenceService.saveBoolValue(_keyLunchNotification, state);
      _isLunchNotificationEnabled = state;
      _message = "Your notification preference changed";

      if (state) {
        showLunchNotification();
      } else {
        await cancelNotification(_lunchNotificationId);
      }

      notifyListeners();
    } catch (e) {
      _message = "Failed to toggle notification preferences";
      notifyListeners();
    }
  }

  void getLunchNotification() {
    try {
      _isLunchNotificationEnabled = _preferenceService.getBoolValue(
        _keyLunchNotification,
      );
      notifyListeners();
    } catch (e) {
      _message = "Failed to load theme preferences";
      notifyListeners();
    }
  }
}
