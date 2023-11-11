import 'package:flutter/material.dart';
import 'package:timebloc/init_app.dart';
import 'package:timebloc/utils/utils.dart';

import '../model/event.dart';
import '../model/routine.dart';
import '../model/tag.dart';

class RoutinesProvider extends ChangeNotifier {
  Future<bool> addRoutine(Routine event) async {
    await timeBlockDatabase.routineDao.insertRoutine(event);
    getRoutines();
    return true;
  }

  Future<bool> updateRoutine(Routine event) async {
    await timeBlockDatabase.routineDao.updateRoutie(event);
    int index = -1;
    for (var element in routines) {
      if (event.id == element.id) {
        index = routines.indexOf(element);
        break;
      }
    }
    if (index != -1) {
      routines.removeAt(index);
      routines.insert(index, event);
      notifyListeners();
    }
    return true;
  }

  List<Routine> routines = [];

  Future<void> deleteRoutine(Routine routine) async {
    await timeBlockDatabase.routineDao.deleteRoutine(routine);
    await timeBlockDatabase.eventDao.deleteByRoutineId(routine.id!);
    getRoutines();
    return;
  }

  void getRoutines() async {
    routines.clear();
    List<Routine> e = await timeBlockDatabase.routineDao.findAllRoutines();
    for (Routine routine in e) {
      routine.events =
          await timeBlockDatabase.eventDao.findAllEventsByRoutine(routine.id!);
    }
    routines.addAll(e);
    notifyListeners();
  }
}
