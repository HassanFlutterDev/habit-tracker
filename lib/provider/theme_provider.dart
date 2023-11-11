import 'package:flutter/material.dart';
import 'package:timebloc/init_app.dart';

import '../model/tag.dart';
import '../utils/color_resources.dart';

class ThemeProvider extends ChangeNotifier {
  static const IS_DARK_MODE = "is_dark_theme";

  ThemeProvider() {
    bool? result = sharedPreferences.getBool(IS_DARK_MODE);
    if (result != null) {
      isDark = result;
    }
  }

  ThemeData newTheme = ThemeData(
    primarySwatch: ColorResources.PRIMARY_MATERIAL,
    brightness: Brightness.light,
    primaryColor: ColorResources.PRIMARY_MATERIAL,
  );
  ThemeData darkTheme = ThemeData(
    primaryColor: ColorResources.DARK_GREY,
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: ColorResources.DARK_GREY,
    // backgroundColor: ColorResources.DARK_GREY
  );

  bool isDark = false;

  void changeTheme(bool isDark) {
    this.isDark = isDark;
    sharedPreferences.setBool(IS_DARK_MODE, isDark);
    notifyListeners();
  }
}
