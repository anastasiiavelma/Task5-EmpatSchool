import 'package:shared_preferences/shared_preferences.dart';

class DarkTheme {
  static const theme = "theme";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(theme, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(theme) ?? false;
  }
}
