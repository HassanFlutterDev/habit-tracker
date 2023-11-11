import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorResources {



static  Color progressLightColor = Color(0xffece7e7);


  static Color getSecondaryColor() {
    return Color(0xffa91498e);
  }

  static Color getColor5() {
    return Color(0xFF3C90D3);
  }

  static Color getDecorationColor() {
    return ColorResources.GREY.withOpacity(0.9);
  }

  static Color getColor9() {
    return Color(0xFFE67E5D);
  }

  static Color getEtc1() {
    return Color(0xFFFA4381);
  }

  static Color getEtc2() {
    return Color(0xFFFD9473);
  }

  static Color getSecondaryLightColor() {
    return Color(0xffef97b9);
  }

  static Color getSecondaryColorLight() {
    return Color(0xffd90b5a);
  }

  static Color getShadiHall1() {
    return Color(0xFF46AAA1);
  }

  static Color getShadiHall2() {
    return Color(0xFFAA654F);
  }

  static LinearGradient getBusinessCardColor(BuildContext cxt, String type) {
    List<Color> list = [];
    if (type == null || type.isEmpty) {
      list.add(ColorResources.getEtc1());
      list.add(ColorResources.getEtc2());
    } else if (type == "Retail") {
      list.add(ColorResources.getPrimary(cxt));
      list.add(ColorResources.getSecondaryColor());
    } else if (type == "Wholesale") {
      list.add(ColorResources.getColor5());
      list.add(ColorResources.getColor9());
    } else if (type == "Restaurant & Shadi hall") {
      list.add(ColorResources.getShadiHall1());
      list.add(ColorResources.getShadiHall2());
    } else {
      list.add(ColorResources.getEtc1());
      list.add(ColorResources.getEtc2());
    }

    return LinearGradient(
      colors: list,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.0, 1.0],
    );
  }

  static Color getLightSkyBlue(BuildContext context) {
    return Color(0xFF8DBFF6);
  }

  static Color getPrimary(BuildContext context, {bool isBusiness = false}) {
    return Theme
        .of(context)
        .primaryColor;
  }

  static Color getPrimaryColor() {
    return Color(0xFFb93d46);
  }

  static const Color BLACK = Color(0xff000000);
  static const Color LIGHT_BACKGROUND = Color(0xfff8f7f7);

  static const Color WHITE = Color(0xffFFFFFF);
  static const Color LIGHT_SKY_BLUE = Color(0xff8DBFF6);
  static const Color BLUE = Color(0xff1371d5);
  static const Color HARLEQUIN = Color(0xff3FCC01);
  static const Color CERISE = Color(0xffE2206B);

  static const Color GREY = Color(0xffefefef);
  static const Color GRAY = Color(0xff757575);
  static const Color DARK_GREY = Color(0xff5f5f5f);
  static const Color RED = Color(0xFFD32F2F);
  static const Color YELLOW = Color(0xFFFFAA47);
  static const Color HINT_TEXT_COLOR = Color(0xff9E9E9E);

  static const Color GAINS_BORO = Color(0xffE6E6E6);
  static const Color TEXT_BG = Color(0xffF3F9FF);
  static const Color ICON_BG = Color(0xffF9F9F9);
  static const Color HOME_BG = Color(0xffF0F0F0);
  static const Color IMAGE_BG = Color(0xffE2F0FF);
  static const Color SELLER_TXT = Color(0xff92C6FF);
  static const Color CHAT_ICON_COLOR = Color(0xffD4D4D4);
  static const Color LOW_GREEN = Color(0xffEFF6FE);
  static const Color GREEN = Color(0xff23CB60);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor PRIMARY_MATERIAL =
  MaterialColor(0xFF192D6B, colorMap);
}
