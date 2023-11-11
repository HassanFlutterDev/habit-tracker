import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:timebloc/model/tag.dart';
import 'package:timebloc/utils/shared_pref_helper.dart';
import 'package:timebloc/utils/utils.dart';

@entity
class Event {
  @primaryKey
  int? id;
  String date;
  String startTime;
  String endTime;
  String image;
  String name;
  String color;
  bool isImageImojie;
  String tags;
  String? routineDays;
  int? routineId;

  String getStatus() {
    return isExpired() ? "Complete" : "Upcoming";
  }

  Event(
      {this.id,
      required this.date,
      required this.startTime,
      this.routineDays,
      required this.name,
      required this.endTime,
      required this.image,
      required this.color,
      required this.isImageImojie,
      required this.tags,
      this.routineId});

  List<Tag> getTags() {
    List<dynamic> jsons = jsonDecode(tags);
    List<Tag> t = [];
    for (var element in jsons) {
      t.add(Tag.fromJson(element));
    }
    return t;
  }

  List<dynamic> getDays() {
    if (routineDays == null) {
      return [];
    }
    List<dynamic> jsons = jsonDecode(routineDays!);
    return jsons;
  }

  String getFormattedEndTime() {
    // if (SharePrefHelper.canUse24Format()) {
    //   return endTime;
    // }
    return getFormattedTime(endTime);
  }

  String getFormattedStartTime() {
    // if (SharePrefHelper.canUse24Format()) {
    //   return startTime;
    // }
    return getFormattedTime(startTime);
  }

  bool isExpired() {
    if (routineId != null) {
      return false;
    }
    DateTime currentTime = DateTime.now();
    String dateT = "$date $endTime";
    DateTime dateTime = getDateTimeFromDateTimeString(dateT);
    var result = currentTime.difference(dateTime);
    // print(dateT.toString());
    // print('result $result');
    return !result.isNegative;
  }

  String getDuration() {
    return getTimeDifference(startTime, endTime);
  }
}
