import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/init_app.dart';
import 'package:timebloc/main.dart';
import 'package:timebloc/provider/routines_provider.dart';
import 'package:timebloc/utils/utils.dart';

import '../model/event.dart';

class EventsProvider extends ChangeNotifier {
  String selectedDate = "";
  DateTime? selectedDateTime;

  void setSelectedDateTime(DateTime dateTime) {
    selectedDateTime = dateTime;
    selectedDate = getFormattedDate(dateTime);
  }

  Future<bool> addEvent(Event event) async {
    await timeBlockDatabase.eventDao.insertEvent(event);
    if (event.routineId != null) {
      Provider.of<RoutinesProvider>(navigatorKey.currentContext!, listen: false)
          .getRoutines();
      getRoutineEvent();
    }
    return true;
  }

  Future<bool> updateEvent(Event event) async {
    await timeBlockDatabase.eventDao.updateEvent(event);
    int index = -1;
    if (event.routineId != null) {
      getRoutineEvent();
    } else {
      for (var element in events) {
        if (element != null && event.id == element!.id) {
          index = events.indexOf(element);
          break;
        }
      }
      if (index != -1) {
        events.removeAt(index);
        events.insert(index, event);
        notifyListeners();
      }
    }

    return true;
  }

  List<Event?> events = [];
  List<Event?> routineEvents = [];

  String day = "";
  int routineId = 0;

  void setDataForRoutine(int id, String d) {
    day = d;
    routineId = id;
  }

  void getRoutineEvent() async {
    routineEvents.clear();
    List<Event> e =
        await timeBlockDatabase.eventDao.findAllEventsByRoutine(routineId);

    for (var element in e) {
      if (element.getDays().contains(day)) {
        routineEvents.add(element);
      }
    }
    if (e.isEmpty) {
      routineEvents.add(null);
      routineEvents.add(null);
      routineEvents.add(null);
    }
    routineEvents.add(null);
    notifyListeners();
  }

  void getEvent() async {
    events.clear();
    List<Event> e =
        await timeBlockDatabase.eventDao.findAllEventsByDate(selectedDate);
    events.addAll(e);
    if (e.isEmpty) {
      events.add(null);
      events.add(null);
    }
    events.add(null);
    notifyListeners();
  }
}
