import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:timebloc/dao/event_dao.dart';
import 'package:timebloc/dao/routine_dao.dart';
import 'package:timebloc/dao/tag_dao.dart';
import '../model/event.dart';
import '../model/routine.dart';
import '../model/tag.dart';

part 'time_bloc_database.g.dart';

@Database(version: 1, entities: [Event, Tag, Routine])
abstract class TimeBlocDatabase extends FloorDatabase {
  EventDao get eventDao;

  RoutineDao get routineDao;

  TagDao get tagDao;
}
