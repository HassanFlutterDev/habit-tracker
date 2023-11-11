import 'package:timebloc/init_app.dart';

class SharePrefHelper {
  static const selectedDay = "selectedDay";
  static const timeFormat24HourEnabled = "timeFormat24HourEnabled";

  static void setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  static String getString(String key, String defaultValue) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  static void setBoolean(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

  static bool getBoolean(String key, bool defaultValue) {
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  static bool canUse24Format() {
    return sharedPreferences.getBool(timeFormat24HourEnabled) ?? false;
  }
}
