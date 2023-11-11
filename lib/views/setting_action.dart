import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/icon_decoration.dart';

class SettingActionWidget extends StatelessWidget {
  IconData icon;
  String title;
  String subTitle;
  Function? onClick;

  SettingActionWidget(
      {required this.title,
      required this.icon,
      this.subTitle = "",
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: Row(
        children: [
          DecoratedIcon(icon),
          SizedBox(
            width: getWidthMargin(context, 2),
          ),
          Expanded(
              child: Text(
            title,
            style: titilliumRegular.copyWith(
                color: getTitleColor(context),
                fontSize: Dimensions.FONT_SIZE_DEFAULT),
          )),
          SizedBox(
            width: getWidthMargin(context, 2),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: ColorResources.DARK_GREY.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
