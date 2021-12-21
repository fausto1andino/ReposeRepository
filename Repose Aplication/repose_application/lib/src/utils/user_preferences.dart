import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get mode {
    return _prefs.getBool('mode') ?? false;
  }

  set mode(bool value) {
    _prefs.setBool('mode', value);
  }
}
