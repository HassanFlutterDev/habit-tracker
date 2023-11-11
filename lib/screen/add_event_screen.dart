import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/main.dart';

import 'package:timebloc/provider/tags_provider.dart';
import 'package:timebloc/screen/tags_screen.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/color_picker_bottom_sheet.dart';
import 'package:timebloc/views/custom_button.dart';
import 'package:timebloc/views/custom_text_field.dart';
import 'package:timebloc/views/horizontal_selection.dart';
import 'package:timebloc/views/icon_decoration.dart';
import 'package:timebloc/views/image_decoration.dart';
import 'package:timebloc/views/imoji_decoration.dart';
import 'package:timebloc/views/imoji_picker_widget.dart';
import 'package:timebloc/views/tag_view.dart';
import 'package:timebloc/views/title_more_text.dart';

import '../model/event.dart';
import '../model/tag.dart';
import '../model/time_duration.dart';
import '../model/time_duration_unit.dart';
import '../provider/events_provider.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../views/custom_duration_picker_bottom_sheet.dart';

class AddEventScreen extends StatefulWidget {
  String name;
  String startTime;
  String date;
  String endTime;
  String image;
  String color;
  bool isImoji;
  int? id;
  int? routineId;
  bool isRoutineEvent;
  List<Tag> selectedTags = [];
  List<String> selectedDays = [];

  AddEventScreen(
      {super.key,
      required this.date,
      required this.name,
      required this.selectedTags,
      this.isRoutineEvent = false,
      this.routineId,
      this.selectedDays = const [],
      this.startTime = "",
      this.color = "",
      this.id,
      this.endTime = "",
      required this.isImoji,
      this.image = ""});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  TextEditingController textEditingController = TextEditingController();
  late TimeDurationUnit selectedTimeDuration;

  List<Tag> selectedTags = [];

  // List<String> durations = [
  //   "01:10 to 02:10",
  //   "01:10 to 03:10",
  //   "04:10 to 04:10",
  //   "05:10 to 06:10",
  //   "06:10 to 07:10",
  //   "07:10 to 08:10"
  // ];
  String selectedColor = "";
  List<TimeDuration> timeDurations = [];
  int selectedTimeDurationIndex = 0;
  List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  List<String> selectedDays = [];

  void initTimeDurations() {
    timeDurations.clear();
    int differenceHours = 0;
    int differenceMinutes = 0;
    if (selectedTimeDuration.type == "Min") {
      differenceMinutes = selectedTimeDuration.unit;
    } else {
      differenceHours = selectedTimeDuration.unit;
    }

    int hour = 1;
    int minutes = 15;
    int index = 0;
    while (index < 23) {
      print(differenceMinutes.toString());
      print(differenceHours.toString());
      String hoursString = getWithZero(hour);
      String minutesString = getWithZero(minutes);
      String startTime = "$hoursString:$minutesString:00";
      hour = hour + differenceHours;
      minutes = minutes + differenceMinutes;
      if (minutes > 60) {
        minutes = minutes % 60;
        ++hour;
      }
      String endHoursString = getWithZero(hour);
      String endMinutesString = getWithZero(minutes);
      String endTime = "$endHoursString:$endMinutesString:00";
      TimeDuration duration =
          TimeDuration(startTime: startTime, endTime: endTime);
      timeDurations.add(duration);
      index++;
    }
  }

  List<TimeDurationUnit> durationUnits = [];

  void initDurationUnits() {
    TimeDurationUnit timeDurationUnit = TimeDurationUnit(unit: 15, type: "Min");
    TimeDurationUnit timeDurationUnit1 =
        TimeDurationUnit(unit: 30, type: "Min");
    TimeDurationUnit timeDurationUnit2 =
        TimeDurationUnit(unit: 45, type: "Min");
    TimeDurationUnit timeDurationUnit3 = TimeDurationUnit(unit: 1, type: "Hr");

    durationUnits.add(timeDurationUnit);
    durationUnits.add(timeDurationUnit1);
    durationUnits.add(timeDurationUnit2);
    durationUnits.add(timeDurationUnit3);
    selectedTimeDuration = durationUnits[durationUnits.length - 1];
  }

  @override
  void initState() {
    selectedTags = widget.selectedTags;
    selectedDays = widget.selectedDays;
    print("Event Id${widget.id}");
    selectedColor = widget.color;
    if (selectedColor.isEmpty) {
      selectedColor = colorList[0];
    }

    initDurationUnits();
    initTimeDurations();
    super.initState();
    textEditingController.text = widget.name;

    print(widget.selectedDays.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: getBouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_LARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Row(
                        children: [
                          InkWell(
                              child: DecoratedIcon(Icons.close),
                              onTap: () {
                                popWidget(context);
                              }),
                          Expanded(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Text(
                                  widget.id == null
                                      ? "New Event"
                                      : "Update Event",
                                  style: titleHeaderExtra.copyWith(
                                      color:
                                          getTitleColor(context, opacity: 1)),
                                ),
                              ),
                            ),
                          ),
                          // DecoratedImage(checkMarkIcon),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_LARGE,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: CustomTextField(
                        hintText: "Event Name...",
                        textEditingController: textEditingController,
                      ),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 1),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return ImojiPickerWidget(
                                    image: widget.image,
                                    imojiPickerCallback: (imoji, isImoji) {
                                      widget.image = imoji;
                                      widget.isImoji = isImoji;
                                      setState(() {});
                                    },
                                    isImoji: false,
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT,
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              child: Row(
                                children: [
                                  widget.isImoji
                                      ? DecoratedEmoji(
                                          widget.image,
                                          size: 20,
                                          backgroundColor: selectedColor,
                                        )
                                      : DecoratedImage(
                                          widget.image.isNotEmpty
                                              ? widget.image
                                              : emailIcon,
                                          backgroundColor: selectedColor,
                                          isColorFull: true),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Icon",
                                    style: titleHeader.copyWith(
                                        color:
                                            getTitleColor(context, opacity: 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return ColorPickerBottomSheet(
                                    selected: selectedColor,
                                    colorPickerCallback: (color) {
                                      selectedColor = color;
                                      setState(() {});
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT,
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    decoration: BoxDecoration(
                                        color:
                                            ColorResources.getDecorationColor(),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      decoration: BoxDecoration(
                                          color: selectedColor.isNotEmpty
                                              ? getColorFromString(
                                                  selectedColor)
                                              : ColorResources.BLUE,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Color",
                                    style: titleHeader.copyWith(
                                        color:
                                            getTitleColor(context, opacity: 1),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 5),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: TitleMoreText(
                          title: "DURATION",
                          endTextColor: getColorFromString(selectedColor),
                          more: "MORE...",
                          isMore: true,
                          onMoreClick: () {}),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: HorizontalSelection<TimeDurationUnit>(
                          horizontalSelectionTextBuilder: (item) {
                            return item.getString();
                          },
                          list: durationUnits,
                          selected: selectedTimeDuration,
                          onSelected: (s) {
                            setState(() {
                              selectedTimeDuration = s;
                              initTimeDurations();
                            });
                          }),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: TitleMoreText(
                          endTextColor: getColorFromString(selectedColor),
                          title: "WHEN",
                          more: "MORE...",
                          onMoreClick: () {
                            TimeDuration timeDuration =
                                timeDurations[selectedTimeDurationIndex];

                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  CustomDurationPickerBottomSheet(
                                startTime: timeDuration.startTime,
                                endTime: timeDuration.endTime,
                                durationPickerCallback: (startTime, endTime) {
                                  timeDuration.startTime = startTime;
                                  timeDuration.endTime = endTime;
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.GREY.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 1))
                          ],
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      height: getScreenHeight(context) / 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: CupertinoPicker(
                              itemExtent: 40,
                              useMagnifier: true,
                              magnification: 1.2,
                              scrollController:
                                  FixedExtentScrollController(initialItem: 0),
                              onSelectedItemChanged: (int i) {
                                // index = i;/
                                selectedTimeDurationIndex = i;
                              },
                              children: timeDurations.map((value) {
                                print("StartTime" + value.startTime);
                                print("EndTime" + value.endTime);
                                return Center(
                                    child: Text(value.getString(),
                                        style: TextStyle(
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT,
                                            color: getTitleColor(context,
                                                opacity: 0.7))));
                              }).toList(),
                            ),
                          ),
                          widget.isRoutineEvent
                              ? const SizedBox.shrink()
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.MARGIN_SIZE_DEFAULT,
                                      vertical: Dimensions.MARGIN_SIZE_SMALL),
                                  child: CustomButton(
                                      onTap: () {
                                        showBottomSheetDatePicker(context,
                                            getDateTimeFromDate(widget.date),
                                            onSelected:
                                                (DateTime selectedDate) {
                                          setState(() {
                                            widget.date =
                                                getFormattedDate(selectedDate);
                                          });
                                        });
                                      },
                                      buttonText: widget.date,
                                      textColor:
                                          getTitleColor(context, opacity: 1),
                                      textDecoration: TextDecoration.underline,
                                      icon: Icons.calendar_month,
                                      backgroundColor: ColorResources.DARK_GREY
                                          .withOpacity(0.1)),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 5),
                    ),
                    !widget.isRoutineEvent
                        ? const SizedBox.shrink()
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            child: TitleMoreText(
                                title: "Repeat",
                                endTextColor: getColorFromString(selectedColor),
                                more: "",
                                onMoreClick: () {}),
                          ),
                    !widget.isRoutineEvent
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: getHeightMargin(context, 2),
                          ),
                    !widget.isRoutineEvent
                        ? const SizedBox.shrink()
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: getWidthMargin(context, 3)),
                            child: Row(
                              children: days.map((e) {
                                return Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    if (selectedDays.contains(e)) {
                                      selectedDays.remove(e);
                                    } else {
                                      selectedDays.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    decoration: BoxDecoration(
                                        color: selectedDays.contains(e)
                                            ? getColorFromString(widget.color)
                                            : ColorResources.GREY
                                                .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorResources.GREY
                                                  .withAlpha(10),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              offset: const Offset(0, 1))
                                        ]),
                                    padding: const EdgeInsets.symmetric(
                                        vertical:
                                            Dimensions.PADDING_SIZE_DEFAULT,
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Center(
                                      child: Text(
                                        e,
                                        style: titleHeader.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_SMALL,
                                            color: isDarkMode(context)
                                                ? ColorResources.WHITE
                                                : selectedDays.contains(e)
                                                    ? ColorResources.WHITE
                                                    : ColorResources.DARK_GREY,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ));
                              }).toList(),
                            ),
                          ),
                    SizedBox(
                      height: getHeightMargin(context, 5),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: TitleMoreText(
                          endTextColor: getColorFromString(selectedColor),
                          title: "TAGS",
                          more: "MORE...",
                          onMoreClick: () {
                            startNewScreenWithRoot(context, TagsScreen(), true);
                          }),
                    ),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: ColorResources.GREY.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(0, 1))
                          ],
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Consumer<TagsProvider>(
                        builder: (context, provider, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisCount: 4,
                                      childAspectRatio: 1.5),
                              children: provider.tags.map((e) {
                                int index = -1;
                                for (Tag tag in selectedTags) {
                                  if (e.id == tag.id) {
                                    index = selectedTags.indexOf(tag);
                                    break;
                                  }
                                }
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      int index = -1;
                                      for (Tag tag in selectedTags) {
                                        if (e.id == tag.id) {
                                          index = selectedTags.indexOf(tag);
                                          break;
                                        }
                                      }
                                      if (index != -1) {
                                        selectedTags.removeAt(index);
                                      } else {
                                        selectedTags.add(e);
                                      }
                                    });
                                  },
                                  child: TagView(
                                    e,
                                    isSelected: index != -1,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getWidthMargin(context, 20),
                  vertical: getWidthMargin(context, 2)),
              child: CustomButton(
                  onTap: () async {
                    if (widget.isRoutineEvent && selectedDays.isEmpty) {
                      infoSnackBar(context, "Select at least one day");
                      return;
                    }

                    TimeDuration selectedTimeDuration =
                        timeDurations[selectedTimeDurationIndex];
                    String name = textEditingController.text.toString();
                    List<String> tagsString = [];
                    for (var element in selectedTags) {
                      tagsString.add(jsonEncode(element.toJson()));
                    }
                    String tags = jsonEncode(selectedTags);
                    Event event = Event(
                        startTime: selectedTimeDuration.startTime,
                        endTime: selectedTimeDuration.endTime,
                        name: name,
                        routineId: widget.routineId,
                        date: widget.date,
                        color: selectedColor,
                        isImageImojie: widget.isImoji,
                        image: widget.image,
                        routineDays: jsonEncode(selectedDays),
                        tags: tags);

                    if (widget.id != null) {
                      event.id = widget.id;
                      bool result = await Provider.of<EventsProvider>(context,
                              listen: false)
                          .updateEvent(event);

                      infoSnackBar(context, "Event Updated");
                      if (result) {
                        popWidget(context);
                      }
                      return;
                    }

                    bool result = await Provider.of<EventsProvider>(context,
                            listen: false)
                        .addEvent(event);
                    if (result) {
                      infoSnackBar(context, "Event Saved");

                      if (widget.isRoutineEvent) {
                        popWidget(context);
                        return;
                      }
                      pushUntil(context, MainWidget());
                    } else {
                      infoSnackBar(context, "Some thing went wrong");
                    }
                  },
                  buttonText: widget.id == null ? "Add Event" : "Update Event",
                  backgroundColor: getColorFromString(selectedColor)),
            )
          ],
        ),
      ),
    );
  }
}
