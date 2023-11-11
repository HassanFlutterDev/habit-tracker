import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/shared_pref_helper.dart';
import 'package:timebloc/utils/utils.dart';

import '../utils/custom_style.dart';
import '../views/icon_decoration.dart';

class GeneralScreen extends StatefulWidget {
  GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    super.initState();

    for (int i = 0; i <= 23; i++) {
      hours.add(i.toString());
    }
    for (int i = 0; i <= 59; i++) {
      minutes.add(i.toString());
    }
    selectedDay =
        SharePrefHelper.getString(SharePrefHelper.selectedDay, "Saturday");
    is24HourTimeFormat = SharePrefHelper.getBoolean(
        SharePrefHelper.timeFormat24HourEnabled, false);
  }

  List<String> hours = [];
  List<String> minutes = [];
  bool is24HourTimeFormat = false;

  int selectedHourIndex = 0;
  int selectedMinutesIndex = 0;
  String selectedDay = "Saturday";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    SharePrefHelper.setString(SharePrefHelper.selectedDay, selectedDay);
    SharePrefHelper.setBoolean(
        SharePrefHelper.timeFormat24HourEnabled, is24HourTimeFormat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Row(
                    children: [
                      InkWell(
                          child: DecoratedIcon(Icons.arrow_back),
                          onTap: () {
                            popWidget(context);
                          }),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "General",
                              style: titleHeaderExtra.copyWith(
                                  fontSize:
                                      Dimensions.FONT_SIZE_EXTRA_EXTRA_LARGE,
                                  color: getTitleColor(context, opacity: 1)),
                            ),
                            Text(
                              "Settings",
                              style: titleRegular.copyWith(
                                  color: getTitleColor(context, opacity: 1)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeightMargin(context, 3),
                ),
                GeneralSettingContainer(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidthMargin(context, 5),
                      vertical: getWidthMargin(context, 3)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            is24HourTimeFormat ? "Enabled" : "Disabled",
                            style: titleHeader,
                          ),
                          Text(
                            "24 Hour Time",
                            style: titleRegular.copyWith(
                                color: getTitleColor(context, opacity: 1)),
                          ),
                        ],
                      )),
                      Switch.adaptive(
                        value: is24HourTimeFormat,
                        onChanged: (value) {
                          setState(() {
                            is24HourTimeFormat = value;
                          });
                        },
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: getHeightMargin(context, 3),
                ),
                GeneralSettingContainer(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidthMargin(context, 5),
                      vertical: getWidthMargin(context, 3)),
                  child: Column(
                    children: [
                      // ExpandableWidget(
                      //     title: "1 Hour 12 Minutes ",
                      //     subtitle: "Time Interval",
                      //     onExpandClick: () {}),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                useMagnifier: true,
                                magnification: 1.2,
                                scrollController:
                                    FixedExtentScrollController(initialItem: 0),
                                // selectionOverlay: Text("Hour"),
                                onSelectedItemChanged: (int i) {
                                  // index = i;/
                                  selectedHourIndex = i;
                                },
                                children: hours.map((value) {
                                  return Center(
                                      child: Text("$value Hour",
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: getTitleColor(context,
                                                  opacity: 0.7))));
                                }).toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: CupertinoPicker(
                                itemExtent: 40,
                                useMagnifier: true,
                                magnification: 1.2,
                                scrollController:
                                    FixedExtentScrollController(initialItem: 0),
                                // selectionOverlay: Text("Hour"),
                                onSelectedItemChanged: (int i) {
                                  // index = i;/
                                  selectedMinutesIndex = i;
                                },
                                children: minutes.map((value) {
                                  return Center(
                                      child: Text("$value Min",
                                          style: TextStyle(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: getTitleColor(context,
                                                  opacity: 0.7))));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: getHeightMargin(context, 3),
                ),
                GeneralSettingContainer(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidthMargin(context, 5),
                          vertical: getWidthMargin(context, 3)),
                      child: Column(
                        children: [
                          // ExpandableWidget(
                          //     title: selectedDay,
                          //     subtitle: "Week Start",
                          //     onExpandClick: () {}),
                          SizedBox(
                            height: getWidthMargin(context, 3),
                          ),
                          RadioTile(
                              onClick: () {
                                setState(() {
                                  selectedDay = "Saturday";
                                });
                              },
                              day: "Saturday",
                              isChecked: selectedDay == "Saturday"),
                          RadioTile(
                              onClick: () {
                                setState(() {
                                  selectedDay = "Sunday";
                                });
                              },
                              day: "Sunday",
                              isChecked: selectedDay == "Sunday"),
                          RadioTile(
                              onClick: () {
                                setState(() {
                                  selectedDay = "Monday";
                                });
                              },
                              day: "Monday",
                              isChecked: selectedDay == "Monday"),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioTile extends StatelessWidget {
  Function onClick;
  String day;
  bool isChecked;

  RadioTile(
      {required this.onClick, required this.day, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            day,
            style: titleHeader.copyWith(color: ColorResources.GRAY),
          ),
        ),
        Radio(
          value: isChecked,
          groupValue: true,
          onChanged: (value) {
            onClick();
          },
        )
      ],
    );
  }
}

class GeneralSettingContainer extends StatelessWidget {
  Widget child;

  GeneralSettingContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getHeightMargin(context, 0.9),
          horizontal: getWidthMargin(context, 4)),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: ColorResources.DARK_GREY.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1))
          ]),
      child: child,
    );
  }
}

class ExpandableWidget extends StatelessWidget {
  String title, subtitle;
  Function onExpandClick;

  ExpandableWidget(
      {required this.title,
      required this.subtitle,
      required this.onExpandClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: titleHeader,
              ),
              Text(
                subtitle,
                style: titleRegular.copyWith(
                    color: getTitleColor(context, opacity: 1)),
              ),
            ],
          ),
        ),
        InkWell(
            child: const Icon(Icons.keyboard_arrow_down_rounded),
            onTap: () {
              onExpandClick();
            }),
      ],
    );
  }
}
