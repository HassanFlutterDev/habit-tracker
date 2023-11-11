import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/dimensions.dart';

import '../utils/color_resources.dart';
import '../utils/utils.dart';

class SettingDecoratedContainer extends StatelessWidget {
  Widget child;

  SettingDecoratedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: isDarkMode(context)
                    ? ColorResources.WHITE.withOpacity(0.2)
                    : ColorResources.GREY.withOpacity(0.5),
                spreadRadius: 4)
          ]),
      child: child,
    );
  }
}
