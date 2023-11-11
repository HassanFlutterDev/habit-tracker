import 'package:flutter/material.dart';
import 'package:timebloc/utils/utils.dart';

import '../utils/shared_pref_helper.dart';

class EventType {
  String name;
  String color;
  String image;
  String startTime;
  String endTime;

  EventType(this.name, this.image, this.color, this.startTime, this.endTime);

  String getDuration() {
    if (SharePrefHelper.canUse24Format()) {
      return "$startTime - $endTime ${getTimeDifference(startTime, endTime)}";
    }

    return "${getFormattedTime(startTime)} - ${getFormattedTime(endTime)} ${getTimeDifference(startTime, endTime)}";
  }
}
