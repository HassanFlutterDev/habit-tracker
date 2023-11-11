import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import '../utils/custom_style.dart';
import '../utils/utils.dart';

typedef HorizontalSelectionTextBuilder<T> = String Function(T item);

class HorizontalSelection<T> extends StatelessWidget {
  List<T> list;

  Function onSelected;
  T? selected;
  HorizontalSelectionTextBuilder<T> horizontalSelectionTextBuilder;

  HorizontalSelection(
      {super.key,
      required this.list,
      this.selected,
      required this.onSelected,
      required this.horizontalSelectionTextBuilder});

  @override
  Widget build(BuildContext context) {
    List<Expanded> widgetList = [];
    for (var element in list) {
      Expanded expanded = Expanded(
          child: InkWell(
        onTap: () {
          onSelected(element);
        },
        child: Container(
          decoration: BoxDecoration(
            color: selected == element
                ? isDarkMode(context)
                    ? ColorResources.DARK_GREY
                    : Theme.of(context).cardColor
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
              horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Center(
            child: Text(
              horizontalSelectionTextBuilder(element),
              style: titleHeader.copyWith(
                  color: isDarkMode(context)
                      ? ColorResources.WHITE
                      : ColorResources.DARK_GREY,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ));
      widgetList.add(expanded);
    }
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? Theme.of(context).cardColor
            : ColorResources.getDecorationColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: widgetList,
      ),
    );
  }
}
