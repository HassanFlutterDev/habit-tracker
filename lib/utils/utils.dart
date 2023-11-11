import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_route.dart';
import 'package:timebloc/utils/dimensions.dart';

List<String> colorList = [
  "E59866",
  "6462E0",
  "E06279",
  "E062DE",
  "776CA6",
  "797E93",
  "0B6287",
  "83D2C8",
  "83D29A",
  "C2C952",
  "6B4949",
];

BouncingScrollPhysics getBouncingScrollPhysics() {
  return const BouncingScrollPhysics();
}

void infoSnackBar(BuildContext context, String message) {
  snakeBar(context, message, ColorResources.BLUE);
}

String getWithZero(int number) {
  if (number < 10) {
    return "0$number";
  }
  return "$number";
}

void snakeBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    elevation: 5,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_LARGE,
        horizontal: Dimensions.MARGIN_SIZE_LARGE),
  ));
}

RoundedRectangleBorder getCardShape(double radius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );
}

String getCurrentDate() {
  return getFormattedDate(DateTime.now());
}

DateTime getDateTimeFromTime(String date) {
  var formatter = DateFormat('HH:mm:ss');
  DateTime dateTime = formatter.parse(date);
  return dateTime;
}

DateTime getDateTimeFromDate(String date) {
  var formatter = DateFormat('yyyy-MM-dd');
  DateTime dateTime = formatter.parse(date);
  return dateTime;
}

DateTime getDateTimeFromDateTimeString(String date) {
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime dateTime = formatter.parse(date);
  return dateTime;
}

String getCurrentTime() {
  var formatter = DateFormat("h:mm a");
  return formatter.format(DateTime.now());
}

String getCurrentServerTime({DateTime? dateTime}) {
  // var formatter = DateFormat("hh:mm:ss");
  DateTime d = dateTime ?? DateTime.now();
  return "${getWithZero(d.hour)}:${getWithZero(d.minute)}:${getWithZero(d.second)}";
}

String getMinutesIntoDuration(int minutes) {
  int hours = minutes ~/ 60;
  minutes = (minutes % 60);
  if (hours == 0) {
    return "$minutes Min";
  }
  if (minutes == 0) {
    return "$hours Hr";
  }
  return "$hours Hr $minutes Min";
}

int getTimeDifferenceInMinutes(String startTime, String endTime) {
  DateTime old = getDateTimeFromTime(startTime);
  DateTime secondDateObject = getDateTimeFromTime(endTime);
  Duration duration = secondDateObject.difference(old);
  return duration.inMinutes;
}

String getTimeDifference(String startTime, String endTime) {
  return getMinutesIntoDuration(getTimeDifferenceInMinutes(startTime, endTime));
}

Future pushUntil(BuildContext context, Widget widget) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Color getColorFromString(String code) {
  return Color(int.parse("0xff$code"));
}

void popWidget(BuildContext context) {
  Navigator.of(context).pop();
}

String getFormattedDate(DateTime date) {
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(date);
  return formattedDate;
}

Future startNewScreenWithRoot(
    BuildContext context, Widget widget, bool rootNavigator) {
  return Navigator.of(context, rootNavigator: rootNavigator).push(MyCustomRoute(
    widget,
  ));
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Map<String, String> getDaysMap() {
  return {
    "Monday": "MON",
    "Tuesday": "TUE",
    "Wednesday": "WED",
    "Thursday": "THU",
    "Friday": "FRI",
    "Saturday": "SAT",
    "Sunday": "SUN",
  };
}

String getDayNameFromDate(String date) {
  DateTime dateTime = DateFormat("yyyy-MM-dd").parse(date);
  return DateFormat('EEEE').format(dateTime);
}

double getWidthMargin(BuildContext context, double percentage) {
  double width = getScreenWidth(context);
  return (width / 100) * percentage;
}

double getHeightMargin(BuildContext context, double percentage) {
  double width = getScreenHeight(context);
  return (width / 100) * percentage;
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

Color getTitleColor(BuildContext context, {double opacity = 0.3}) {
  return Theme.of(context).brightness == Brightness.dark
      ? ColorResources.WHITE
      : ColorResources.DARK_GREY.withOpacity(opacity);
}

String getFormattedTime(String time) {
  var dateFormat = DateFormat("h:mm:ss");
  return DateFormat("h:mm a").format(dateFormat.parse(time));
}

void showBottomSheetDatePicker(BuildContext context, DateTime selectedDate,
    {required Function onSelected}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 5000)),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          selectedDayPredicate: (date) {
            return isSameDay(selectedDate, date);
          },
          onDaySelected: (date, focusedDay) {
            onSelected(date);
            popWidget(context);
          },
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, date, _) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      });
}
