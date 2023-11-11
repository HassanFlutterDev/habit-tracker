import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/init_app.dart';
import 'package:timebloc/model/tag.dart';
import 'package:timebloc/payment_api.dart';
import 'package:timebloc/provider/tags_provider.dart';
import 'package:timebloc/screen/payment_screen.dart';
import 'package:timebloc/utils/custom_style.dart';

import '../model/event.dart';
import '../utils/color_resources.dart';
import '../utils/utils.dart';
import '../views/weekly_chart_widget.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int touchedIndex = 0;
  List<Event> events = [];
  bool isLoading = true;

  List<Tag> tags = [];

  int getTotalTags() {
    int total = 0;
    for (Event event in events) {
      total += event.getTags().length;
    }
    return total;
  }

  List<Event> getEventsByTag(String tag) {
    List<Event> list = [];
    for (Event event in events) {
      if (event.tags.contains(tag)) {
        list.add(event);
      }
    }
    return list;
  }

  List<Event> getEventsByDay(String dayName) {
    List<Event> list = [];
    for (Event event in events) {
      try {
        if (event.routineId != null) {
          String day = getDaysMap()[dayName]!;
          bool result = event.routineDays!.contains(day);
          if (result) {
            list.add(event);
          }
        } else {
          String day = getDayNameFromDate(event.date);

          if (day == dayName) {
            list.add(event);
          }
        }
      } catch (e) {}
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    events.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<Event> list = await timeBlockDatabase.eventDao.findAllEvents();
      tags = await timeBlockDatabase.tagDao.findAllTags();
      isLoading = false;
      events = list;
      setState(() {});
    });
  }

  // getPurchase() async {
  //   if (!PurchaseApi.isPaid) {
  //     Navigator.push(context, CupertinoPageRoute(builder: (_) {
  //       return PaymentScreen();
  //     }));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return !PurchaseApi.isPaid
        ? PaymentScreen(
            isshow: true,
          )
        : Scaffold(
            body: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: getBouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: getHeightMargin(context, 2),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: StatItem("Total Events",
                                      events.length.toString())),
                              Expanded(
                                  child: StatItem(
                                      "Total Tags", tags.length.toString())),
                            ],
                          ),
                          SizedBox(
                            height: getHeightMargin(context, 1),
                          ),
                          // BarChart(
                          //   BarChartData(),
                          //   swapAnimationDuration: const Duration(milliseconds: 150),
                          //   // Optional
                          //   swapAnimationCurve: Curves.linear, // Optional
                          // ),
                          StatContainer(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidthMargin(context, 5),
                                    vertical: 10),
                                child: Text(
                                  "Tags",
                                  style: titleHeaderExtra.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          getTitleColor(context, opacity: 1)),
                                ),
                              ),
                              // SizedBox(
                              //   height: 200,
                              //   child: PieChart(
                              //     PieChartData(
                              //       pieTouchData: PieTouchData(
                              //         touchCallback:
                              //             (FlTouchEvent event, pieTouchResponse) {
                              //           setState(() {
                              //             if (!event.isInterestedForInteractions ||
                              //                 pieTouchResponse == null ||
                              //                 pieTouchResponse.touchedSection ==
                              //                     null) {
                              //               touchedIndex = -1;
                              //               return;
                              //             }
                              //             touchedIndex = pieTouchResponse
                              //                 .touchedSection!.touchedSectionIndex;
                              //           });
                              //         },
                              //       ),
                              //       borderData: FlBorderData(
                              //         show: false,
                              //       ),
                              //       sectionsSpace: 0,
                              //       centerSpaceRadius: 40,
                              //       sections: showingSections(),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: getHeightMargin(context, 3)),
                              Consumer<TagsProvider>(
                                builder: (context, provider, child) {
                                  return BaseListView(
                                    provider.tags,
                                    baseListWidgetBuilder: (data, pos) {
                                      return TagStatItem(
                                        data!,
                                        max: getTotalTags(),
                                        progress:
                                            getEventsByTag(data.name).length,
                                      );
                                    },
                                    scrollable: false,
                                    shrinkable: true,
                                  );
                                },
                              ),
                              SizedBox(height: getHeightMargin(context, 1)),
                            ],
                          )),
                          StatContainer(
                              child: BarChartSample1(
                            name: 'Number Of Events',
                            max: events.length,
                            mondays: getEventsByDay("Monday").length,
                            tuesdays: getEventsByDay("Tuesday").length,
                            wednesdays: getEventsByDay("Wednesday").length,
                            thursday: getEventsByDay("Thursday").length,
                            friday: getEventsByDay("Friday").length,
                            saturday: getEventsByDay("Saturday").length,
                            sunday: getEventsByDay("Sunday").length,
                          )),
                          StatContainer(
                              child: BarChartSample1(
                            name: 'Average Event Duration',
                            max: events.length,
                            mondays: getEventsByDay("Monday").length,
                            tuesdays: getEventsByDay("Tuesday").length,
                            wednesdays: getEventsByDay("Wednesday").length,
                            thursday: getEventsByDay("Thursday").length,
                            friday: getEventsByDay("Friday").length,
                            saturday: getEventsByDay("Saturday").length,
                            sunday: getEventsByDay("Sunday").length,
                          )),
                        ],
                      ),
                    ),
            ),
          );
  }

  List<PieChartSectionData> showingSections() {
    return tags.map((e) {
      final isTouched = e == touchedIndex;
      // final isTouched = false;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double percentage = getEventsByTag(e.name).length / getTotalTags() * 100;
      if (percentage.toString() == "NaN") {
        percentage = 1.0;
      }
      print(percentage.toString());
      return PieChartSectionData(
        color: getColorFromString(e.color),
        value: percentage,
        title: '${percentage.toInt()}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: ColorResources.WHITE,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}

class StatItem extends StatelessWidget {
  String title;
  String subTitle;

  StatItem(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: getHeightMargin(context, 1),
          horizontal: getWidthMargin(context, 4)),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorResources.DARK_GREY.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1))
          ],
          color: isDarkMode(context)
              ? Theme.of(context).cardColor
              : ColorResources.WHITE.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: titleHeaderExtra.copyWith(
                  fontSize: 20, color: getTitleColor(context, opacity: 0.8)),
            ),
            const SizedBox(height: 5),
            Text(
              subTitle,
              style: titilliumRegular.copyWith(
                  color: getTitleColor(context, opacity: 0.8),
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class TagStatItem extends StatelessWidget {
  Tag tag;

  int max = 0;
  int progress = 0;

  TagStatItem(this.tag, {required this.max, required this.progress});

  @override
  Widget build(BuildContext context) {
    double value = (progress / max * 100) / 100;
    if (value.toString() == "NaN") {
      value = 0;
    }
    print(value.toString());
    Color color = getColorFromString(tag.color);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getWidthMargin(context, 3),
          vertical: getWidthMargin(context, 2)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 5,
              ),
              SizedBox(
                width: getWidthMargin(context, 1),
              ),
              Text(
                tag.name,
                style: titilliumRegular.copyWith(
                    color: getTitleColor(context, opacity: 1),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            value: value,
            color: color,
          )
        ],
      ),
    );
  }
}

class StatContainer extends StatelessWidget {
  Widget child;

  StatContainer({required this.child});

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
