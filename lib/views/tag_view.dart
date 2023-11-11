import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/utils.dart';

import '../model/tag.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';

class TagView extends StatelessWidget {
  Tag tag;

  bool isSelected;

  TagView(this.tag, {this.isSelected = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected
              ? isDarkMode(context)
                  ? ColorResources.DARK_GREY.withOpacity(0.5)
                  : ColorResources.DARK_GREY.withOpacity(0.1)
              : Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: []),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
          horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
              color: getColorFromString(tag.color),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            child: Text(
              tag.name,
              style: titleHeader.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: isDarkMode(context)
                      ? ColorResources.WHITE
                      : ColorResources.DARK_GREY,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
