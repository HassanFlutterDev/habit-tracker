import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/utils.dart';

import '../utils/dimensions.dart';

class AddEventItem extends StatelessWidget {
  AddEventItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getHeightMargin(context, 0.9),
          horizontal: getWidthMargin(context, 2)),
      decoration: BoxDecoration(
          color: isDarkMode(context)
              ? Theme.of(context).cardColor
              : ColorResources.WHITE.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: ColorResources.DARK_GREY.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorResources.DARK_GREY.withAlpha(20),
                borderRadius: BorderRadius.circular(50),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Icon(
                  Icons.add,
                  color: getTitleColor(context,opacity: 1),
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text(
              "Add Event",
              style: titleRegular.copyWith(
                  color: getTitleColor(context,opacity: 0.7)),
            )
          ],
        ),
      ),
    );
  }
}
