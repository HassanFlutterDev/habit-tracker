import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timebloc/model/event.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/image_decoration.dart';
import 'package:timebloc/views/imoji_decoration.dart';

import '../screen/add_event_screen.dart';
import '../utils/dimensions.dart';
import 'circular_progress.dart';

class EventItem extends StatefulWidget {
  Event event;

  EventItem({super.key, required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> with TickerProviderStateMixin {
  late AnimationController animationController;

  Timer? timer;
  bool status = false;
  String eventDate = '';
  String currentDate = '';
  int currentMinutes = DateTime.now().minute;
  int currenthour = DateTime.now().hour;
  @override
  void initState() {
    super.initState();

    eventDate = widget.event.date.split('-')[2];
    currentDate = DateTime.now().day.toString().length == 1
        ? '0${DateTime.now().day.toString()}'
        : DateTime.now().day.toString();
    print('event date ${widget.event.startTime}');
    print('current date ${widget.event.endTime}');

    animationController = AnimationController(
        duration: const Duration(seconds: 5), vsync: this, value: 1);
    if (widget.event.getStatus() == "Complete") {
      animationController.value = 0.0;
    }
    if (widget.event.routineId == null &&
        !widget.event.isExpired() &&
        eventDate == currentDate) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          int minutes = getTimeDifferenceInMinutes(
              widget.event.startTime, widget.event.endTime);
          int currentMinutes = getTimeDifferenceInMinutes(
              getCurrentServerTime(), widget.event.endTime);
          final percentage = ((1 / minutes) * currentMinutes);
          // print('percentage $percentage');
          animationController.value = percentage;
          int endHour = int.parse(
              '${widget.event.endTime.split(':').first.replaceRange(1, 2, '') == '0' ? widget.event.endTime.split(':').first.replaceAll('0', '') : widget.event.endTime.split(':').first}');
          int endMin = int.parse('${widget.event.endTime.split(':')[1]}');
          int startHour = int.parse(
              '${widget.event.startTime.split(':').first.replaceRange(1, 2, '') == '0' ? widget.event.startTime.split(':').first.replaceAll('0', '') : widget.event.startTime.split(':').first}');
          int startMin = int.parse('${widget.event.startTime.split(':')[1]}');
          // print('hour $startHour');
          // print('minute $startMin');
          if (currenthour > startHour && currenthour < endHour) {
            print('hour passed');
            if (currentMinutes > startMin && currentMinutes < endMin) {
              status = true;
              print('minute passed');
            } else if (currentMinutes == startMin && currentMinutes == endMin) {
              status = true;
              print('minute passed1');
            }
          } else if (currenthour == startHour || currenthour == endHour) {
            print('hour passed1');
            if (currentMinutes > startMin && currentMinutes < endMin) {
              status = true;
              print('minute passed1');
            } else if (currentMinutes == startMin && currentMinutes == endMin) {
              status = true;
              print('minute passed1');
            } else if (currentMinutes > startMin || currentMinutes < endMin) {
              status = true;
              print('minute passed3');
            } else if (currentMinutes == startMin || currentMinutes == endMin) {
              status = true;
              print('minute passed1');
            }
          }

          setState(() {});
          if (widget.event.isExpired()) {
            try {
              print('event date ${widget.event.date}');
              // animationController.value = 100.0;
              timer.cancel();
            } catch (e) {
              print(e.toString());
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.event.getTags();
    return InkWell(
      onTap: () {
        List<String> days = [];
        widget.event.getDays().forEach((element) {
          days.add(element.toString());
        });
        startNewScreenWithRoot(
            context,
            AddEventScreen(
              date: widget.event.date,
              name: widget.event.name,
              isImoji: widget.event.isImageImojie,
              routineId: widget.event.routineId,
              isRoutineEvent: widget.event.routineId != null,
              selectedTags: widget.event.getTags(),
              selectedDays: days,
              color: widget.event.color,
              image: widget.event.image,
              endTime: widget.event.endTime,
              startTime: widget.event.startTime,
              id: widget.event.id,
            ),
            true);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: getHeightMargin(context, 0.9),
                bottom: getHeightMargin(context, 0.9),
                right: getWidthMargin(context, 2),
                left: getWidthMargin(context, 10)),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                  CustomPaint(
                    foregroundPainter: CircularProgress(
                        offSetDivider: 2,
                        radius: 100,
                        strokeWidth: 5,
                        animationController: animationController),
                    child:
                        widget.event.isImageImojie || widget.event.image.isEmpty
                            ? DecoratedEmoji(
                                widget.event.image,
                                size: 25,
                                radius: 30,
                                backgroundColor: widget.event.color,
                              )
                            : DecoratedImage(widget.event.image,
                                isColorFull: true,
                                width: 25,
                                height: 25,
                                radius: 30,
                                backgroundColor: widget.event.color),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: getColorFromString(event.color),
                  //     borderRadius: BorderRadius.circular(50),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  //     child: event.isImageImojie
                  //         ? DecoratedEmoji(event.image)
                  //         : DecoratedImage(event.image,
                  //             isColorFull: true, width: 25, height: 25),
                  //   ),
                  // ),
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.name,
                          style: titleRegular.copyWith(
                              decoration: widget.event.isExpired()
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: getTitleColor(context, opacity: 1)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.event.getDuration(),
                          style: titleRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: getTitleColor(context, opacity: 0.5)),
                        ),
                      ],
                    ),
                  ),
                  widget.event.routineId != null
                      ? const SizedBox.shrink()
                      : Container(
                          decoration: BoxDecoration(
                              color: widget.event.getStatus() == "Complete"
                                  ? ColorResources.GREEN
                                  : status
                                      ? ColorResources.CERISE
                                      : Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Text(
                            status ? 'Processing' : widget.event.getStatus(),
                            style: titleRegular.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimeChip(widget.event.getFormattedStartTime()),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_SMALL,
                ),
                TimeChip(widget.event.getFormattedEndTime())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  String time;

  TimeChip(this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorResources.GRAY.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Text(
        time,
        style: titleRegular.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
            color: isDarkMode(context)
                ? ColorResources.GREY
                : ColorResources.WHITE),
      ),
    );
  }
}
