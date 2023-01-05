import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesHandler {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveBookMark() {}
}
