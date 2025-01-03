import 'package:flutter/material.dart';
import '../models/settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  final _settings = SettingsModel(notificationsEnabled: true, theme: 'Light');

  SettingsModel get settings => _settings;

  void toggleNotifications() {
    _settings.notificationsEnabled = !_settings.notificationsEnabled;
    notifyListeners();
  }

  void changeTheme(String newTheme) {
    _settings.theme = newTheme;
    notifyListeners();
  }
}
