import 'package:appstarter/app/models/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsStorage {
  Future<void> save(AppSettings data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('settings', data.toJson());
  }

  Future<AppSettings> get getData async {
    final prefs = await SharedPreferences.getInstance();
    String? dataString = prefs.getString('settings');

    if (dataString == null) return AppSettings();

    try {
      return AppSettings.fromJson(dataString);
    } on Exception {
      return AppSettings();
    }
  }

  static AppSettingsStorage get instance => AppSettingsStorage();
}
