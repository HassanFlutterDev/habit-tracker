import 'package:flutter/cupertino.dart';

import '../utils/color_resources.dart';
import '../utils/dimensions.dart';

class DecoratedEmoji extends StatelessWidget {
  String image;
  bool isColorFull;

  String backgroundColor = "";
  double size;
  double radius;

  DecoratedEmoji(
    this.image, {
    super.key,
    this.isColorFull = false,
    this.backgroundColor = "",
    this.radius = 10,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
          color: backgroundColor.isNotEmpty
              ? Color(int.parse("0xff$backgroundColor"))
              : ColorResources.getDecorationColor(),
          borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          image,
          style: TextStyle(fontSize: size),
        ),
      ),
    );
  }
}
