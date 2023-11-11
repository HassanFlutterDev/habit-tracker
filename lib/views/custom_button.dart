import 'package:flutter/material.dart';

import '../utils/color_resources.dart';
import '../utils/custom_style.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final bool isBuy;
  bool isVisible;
  bool business;
  Color backgroundColor;
  Color textColor;
  TextDecoration textDecoration;
  IconData? icon;

  CustomButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.isBuy = false,
      this.isVisible = true,
      this.business = false,
      required this.backgroundColor,
      this.textColor = ColorResources.WHITE,
      this.textDecoration = TextDecoration.none,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
      child: Stack(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon == null
                    ? const SizedBox.shrink()
                    : Icon(
                        icon,
                        color: ColorResources.DARK_GREY,
                      ),
                icon == null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        width: 5,
                      ),
                Text(buttonText,
                    style: titilliumSemiBold.copyWith(
                        fontSize: 16,
                        color: textColor,
                        decoration: textDecoration)),
              ],
            ),
          ),
          isVisible
              ? const SizedBox.shrink()
              : Container(
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorResources.DARK_GREY.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(10)),
                ),
        ],
      ),
    );
  }
}
