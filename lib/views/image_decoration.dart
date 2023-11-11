import 'package:flutter/cupertino.dart';

import '../utils/color_resources.dart';
import '../utils/dimensions.dart';
import '../utils/utils.dart';

class DecoratedImage extends StatelessWidget {
  String image;
  bool isColorFull;
  bool isIcon;
  String backgroundColor = "";
  double width, height;

  double radius;
  DecoratedImage(this.image,
      {super.key,
      this.isColorFull = false,
      this.isIcon = false,
      this.backgroundColor = "",
      this.width = 25,
      this.radius = 10,
      this.height = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
          color: backgroundColor.isNotEmpty
              ? Color(int.parse("0xff$backgroundColor"))
              : isDarkMode(context)
                  ? ColorResources.DARK_GREY
                  : ColorResources.getDecorationColor(),
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: isIcon
            ? Icon(
                CupertinoIcons.delete,
                size: 20,
              )
            : Image.asset(
                image,
                height: height,
                color: isColorFull
                    ? null
                    : isDarkMode(context)
                        ? ColorResources.WHITE
                        : ColorResources.DARK_GREY,
                width: width,
              ),
      ),
    );
  }
}
