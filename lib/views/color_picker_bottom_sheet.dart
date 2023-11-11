import 'package:flutter/material.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/colors_widget.dart';
import 'package:timebloc/views/icon_decoration.dart';

import '../utils/MyImages.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';
import 'image_decoration.dart';

class ColorPickerBottomSheet extends StatefulWidget {
  String selected = "";
  ColorPickerCallback colorPickerCallback;

  ColorPickerBottomSheet(
      {required this.selected, required this.colorPickerCallback});

  @override
  State<ColorPickerBottomSheet> createState() => _ColorPickerBottomSheetState();
}

class _ColorPickerBottomSheetState extends State<ColorPickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.MARGIN_SIZE_LARGE),
              topRight: Radius.circular(Dimensions.MARGIN_SIZE_LARGE))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
            vertical: Dimensions.MARGIN_SIZE_LARGE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      popWidget(context);
                    },
                    child: DecoratedIcon(Icons.close)),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        "Select Color",
                        style: titleHeaderExtra.copyWith(
                            color: isDarkMode(context)
                                ? ColorResources.WHITE
                                : ColorResources.DARK_GREY),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.selected.isEmpty) {
                      return;
                    }

                    widget.colorPickerCallback(widget.selected);
                    popWidget(context);
                  },
                  child: DecoratedImage(
                    checkMarkIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getHeightMargin(context, 4),
            ),
            DecoratedImage(
              openBookIcon,
              isColorFull: true,
              backgroundColor: widget.selected,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: getHeightMargin(context, 4),
            ),
            ColorsWidget(
              colorPickerCallback: (color) {
                setState(() {
                  widget.selected = color;
                });
              },
              selected: widget.selected,
            )
          ],
        ),
      ),
    );
  }
}
