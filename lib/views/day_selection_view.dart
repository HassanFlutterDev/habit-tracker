import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timebloc/utils/shared_pref_helper.dart';
import 'package:timebloc/utils/utils.dart';

import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';

class DaySelectionView extends StatefulWidget {
  Function onDaySelected;
  String selected;

  DaySelectionView({required this.onDaySelected, required this.selected});

  @override
  State<DaySelectionView> createState() => _DaySelectionViewState();
}

class _DaySelectionViewState extends State<DaySelectionView> {
  List<String> list = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

  // String selected ="";/

  Map<String, String> mapping = {
    "MON": "Monday",
    "TUE": "Tuesday",
    "WED": "Wednesday",
    "THU": "Thursday",
    "FRI": "Friday",
    "SAT": "Saturday",
    "SUN": "Sunday",
  };

  @override
  void initState() {
    String selectedStartDay =
        SharePrefHelper.getString(SharePrefHelper.selectedDay, "Monday");
    print(selectedStartDay);

    List<String> tempList = [];
    tempList.addAll(list);
    list.clear();
    print(list.length.toString());
    print(tempList.length.toString());

    for (String s in tempList) {
      print(mapping[s]);
      if (mapping[s] == selectedStartDay) {
        List<String> subList = tempList.sublist(tempList.indexOf(s));
        print("SubList" + subList.length.toString());
        list.insertAll(0, subList);
        break;
      }
      list.add(s);
    }
    super.initState();
  }

  Expanded getItem(BuildContext context, String element, String selected,
      Function onSelected) {
    return Expanded(
        child: InkWell(
      onTap: () {
        onSelected(element);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            color: selected == element
                ? Theme.of(context).cardColor
                : ColorResources.GREY.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: ColorResources.GREY.withAlpha(10),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 1))
            ]),
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Center(
          child: Text(
            element,
            style: titleHeader.copyWith(
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                color: isDarkMode(context)
                    ? ColorResources.WHITE
                    : getTitleColor(context, opacity: 1),
                fontWeight: FontWeight.normal),

          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizedBox margin = const SizedBox(
      width: 3,
    );
    return Column(
      children: [
        Row(
          children: list.map((e) {
            return getItem(context, e.toString(), widget.selected, (element) {
              widget.onDaySelected(element);
            });
          }).toList(),
        ),
        SizedBox(
          height: getHeightMargin(context, 3),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getWidthMargin(context, 2),
          ),
          child: Row(
            children: [
              InkWell(
                  child: const Icon(Icons.arrow_back_ios_sharp),
                  onTap: () {
                    if (widget.selected == "MON") {
                      widget.selected = "SUN";
                      widget.onDaySelected(widget.selected);

                      return;
                    }
                    widget.selected = list[list.indexOf(widget.selected) - 1];
                    widget.onDaySelected(widget.selected);
                  }),
              Expanded(
                  child: Center(
                      child: Text(
                mapping[widget.selected]!,
                style: titleRegular.copyWith(
                    color: getTitleColor(context, opacity: 1),
                    fontSize: Dimensions.FONT_SIZE_LARGE),
              ))),
              InkWell(
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                  onTap: () {
                    if (widget.selected == "SUN") {
                      widget.selected = "MON";
                      widget.onDaySelected(widget.selected);
                      return;
                    }
                    widget.selected = list[list.indexOf(widget.selected) + 1];
                    widget.onDaySelected(widget.selected);
                  }),
            ],
          ),
        )
      ],
    );
  }
}
