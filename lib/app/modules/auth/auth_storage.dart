import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  Future<void> save(String data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('auth', data);
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth');
  }

  Future<String?> get getData async {
    final prefs = await SharedPreferences.getInstance();
    String? dataString = prefs.getString('auth');

    if (dataString == null) return null;

    return dataString;
  }

  static AuthStorage get instance => AuthStorage();
}
