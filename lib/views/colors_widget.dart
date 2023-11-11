import 'package:flutter/cupertino.dart';
import 'package:timebloc/utils/utils.dart';
import 'color_item.dart';

typedef ColorPickerCallback = Function(String color);

class ColorsWidget extends StatelessWidget {
  String selected = "";
  ColorPickerCallback colorPickerCallback;

  ColorsWidget({this.selected = "", required this.colorPickerCallback});



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: getHeightMargin(context, 3),
          crossAxisSpacing: getWidthMargin(context, 3),
          crossAxisCount: 4,
          childAspectRatio: 1.5),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        return ColorItem(
          colorList[index],
          colorPickerCallback: colorPickerCallback,
          selected: selected,
        );
      },
    );
  }
}
