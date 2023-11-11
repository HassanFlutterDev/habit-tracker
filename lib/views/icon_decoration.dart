import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/utils.dart';

import '../utils/color_resources.dart';
import '../utils/dimensions.dart';

class DecoratedIcon extends StatelessWidget {
  IconData iconData;

  DecoratedIcon(this.iconData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
          color:isDarkMode(context) ? ColorResources.DARK_GREY : ColorResources.getDecorationColor(),

          borderRadius: BorderRadius.circular(10)),
      child: Icon(iconData, color: isDarkMode(context) ? ColorResources.WHITE :  ColorResources.DARK_GREY),
    );
  }
}
