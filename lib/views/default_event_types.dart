import 'package:flutter/cupertino.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/model/event_type.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/event_type_item.dart';

class DefaultEventTypes extends StatelessWidget {
  String date;

  DefaultEventTypes({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    List<EventType> list = [];
    list.add(EventType(
        "Answer Emails", emailIcon, colorList[0], "10:58:00", "11:58:00"));
    list.add(EventType(
        "Study", stackOfBookIcon, colorList[1], "22:58:00", "23:58:00"));
    list.add(
        EventType("Read", openBookIcon, colorList[2], "13:00:00", "15:00:00"));
    list.add(
        EventType("Coffee", coffeeIcon, colorList[3], "19:30:00", "20:15:00"));

    list.add(EventType(
        "Go for Walk", walkIcon, colorList[4], "07:30:00", "08:00:00"));
    list.add(
        EventType("Go for Run", runIcon, colorList[5], "12:30:00", "13:30:00"));
    list.add(EventType(
        "Workout", workoutIcon, colorList[6], "10:30:00", "12:00:00"));
    list.add(
        EventType("Dinner", dinnerIcon, colorList[7], "19:30:00", "20:15:00"));

    list.add(EventType(
        "Break Fast", dinnerIcon, colorList[8], "08:00:00", "08:30:00"));
    list.add(
        EventType("Lunch", dinnerIcon, colorList[9], "12:30:00", "13:00:00"));
    list.add(
        EventType("Dinner", dinnerIcon, colorList[10], "18:30:00", "19:30:00"));
    return BaseListView(
      list,
      baseListWidgetBuilder: (data, pos) {
        return EventTypeItem(
          data!,
          date: date,
        );
      },
      scrollable: false,
      shrinkable: true,
    );
  }
}
