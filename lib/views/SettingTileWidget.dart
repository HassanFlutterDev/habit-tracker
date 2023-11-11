import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/icon_decoration.dart';

class SettingTileWidget extends StatefulWidget {
  String title;
  String subTitle;
  Function? onClick;
  bool isChecked = false;

  SettingTileWidget({required this.title, this.subTitle = "", this.onClick , this.isChecked = false});

  @override
  State<SettingTileWidget> createState() => _SettingTileWidgetState();
}

class _SettingTileWidgetState extends State<SettingTileWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getWidthMargin(context, 2)),
        padding: EdgeInsets.symmetric(
            horizontal: getWidthMargin(context, 5),
            vertical: getHeightMargin(context, 2)),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: isDarkMode(context)
                      ? ColorResources.WHITE.withOpacity(0.2)
                      : ColorResources.GREY.withOpacity(0.5),
                  spreadRadius: 4)
            ]),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: titilliumRegular.copyWith(
                      color: getTitleColor(context),
                      fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
                Text(
                  widget.subTitle,
                  style: titilliumRegular.copyWith(
                      color: getTitleColor(context),
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ],
            )),
            SizedBox(
              width: getWidthMargin(context, 2),
            ),
            Switch.adaptive(
                value: widget.isChecked,
                onChanged: (value) {
                  if (widget.onClick != null) {
                    widget.onClick!(value);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
