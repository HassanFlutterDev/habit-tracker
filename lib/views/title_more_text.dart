import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import '../utils/custom_style.dart';
import '../utils/utils.dart';

class TitleMoreText extends StatelessWidget {
  String title;
  String more;
  Function onMoreClick;
  Color endTextColor;
  bool isMore;
  TitleMoreText(
      {super.key,
      required this.title,
      required this.more,
      required this.onMoreClick,
      this.isMore = false,
      this.endTextColor = ColorResources.BLUE});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style:
                titleHeader.copyWith(color: getTitleColor(context, opacity: 1)),
          )),
          isMore
              ? Container()
              : Expanded(
                  child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      onMoreClick();
                    },
                    child: Text(
                      more,
                      style: titleHeader.copyWith(color: endTextColor),
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
