import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';

import 'colors_widget.dart';

class ColorItem extends StatelessWidget {
  String color;
  String selected;
  ColorPickerCallback colorPickerCallback;

  ColorItem(this.color,
      {this.selected = "", required this.colorPickerCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        colorPickerCallback(color);
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Color(int.parse("0xff$color")),
            ),
          ),
          selected == color
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset(
                      height: 25,
                      width: 25,
                      checkMarkIcon,
                      color: ColorResources.WHITE,
                    ),
                  ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
