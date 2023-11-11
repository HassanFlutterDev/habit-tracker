import 'package:flutter/material.dart';
import 'package:timebloc/model/tag.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/utils.dart';

import '../screen/add_event_screen.dart';
import '../screen/add_event_types_screen.dart';
import '../screen/add_tag_screen.dart';
import '../utils/dimensions.dart';

class TagItem extends StatelessWidget {
  Tag tag;

  TagItem({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        startNewScreenWithRoot(
            context,
            AddTagScreen(
              tag: tag,
            ),
            true);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_LARGE,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        decoration: BoxDecoration(
            color: isDarkMode(context)
                ? Theme.of(context).cardColor
                : ColorResources.WHITE.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: ColorResources.DARK_GREY.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 1))
            ]),
        child: Row(
          children: [
            Container(
              width: 25,
              decoration: BoxDecoration(
                color: getColorFromString(tag.color),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              height: 70,
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Expanded(
              child: Text(
                tag.name,
                style: titleRegular.copyWith(
                    color: isDarkMode(context)
                        ? ColorResources.WHITE
                        : ColorResources.BLACK.withAlpha(90),
                    fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color:isDarkMode(context)
                  ? ColorResources.WHITE: ColorResources.DARK_GREY.withOpacity(0.5),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
          ],
        ),
      ),
    );
  }
}
