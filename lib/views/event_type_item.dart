import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/utils.dart';

import '../model/event_type.dart';
import '../screen/add_event_screen.dart';
import '../utils/dimensions.dart';

class EventTypeItem extends StatelessWidget {
  EventType eventType;
  String date;

  EventTypeItem(this.eventType, {super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        startNewScreenWithRoot(
            context,
            AddEventScreen(
              date: date,
              name: eventType.name,
              startTime: eventType.startTime,
              endTime: eventType.endTime,
              isImoji: false,
              color: eventType.color,
              image: eventType.image,
              selectedTags: [],
            ),
            true);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_LARGE,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        decoration: BoxDecoration(
            color: isDarkMode(context)
                ? Theme.of(context).cardColor
                : ColorResources.WHITE.withOpacity(0.8),
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
              Container(
                decoration: BoxDecoration(
                  color: getColorFromString(eventType.color),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: Image.asset(
                    eventType.image,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventType.name,
                    style: titleRegular.copyWith(
                        color: getTitleColor(context,opacity: 0.7),
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                  Text(
                    eventType.getDuration(),
                    style: titleRegular.copyWith(
                        color: getTitleColor(context,opacity: 0.7),
                        fontSize: Dimensions.FONT_SIZE_SMALL),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
