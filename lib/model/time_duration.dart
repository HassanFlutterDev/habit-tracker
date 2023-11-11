import 'package:timebloc/utils/shared_pref_helper.dart';
import 'package:timebloc/utils/utils.dart';

class TimeDuration {
  String startTime;
  String endTime;

  TimeDuration({required this.startTime, required this.endTime});

  String getString() {
    if(SharePrefHelper.canUse24Format()){
      return "$startTime $endTime ${getTimeDifference(startTime, endTime)}";

    }
    return "${getFormattedTime(startTime)} ${getFormattedTime(endTime)} ${getTimeDifference(startTime, endTime)}";
  }
}
