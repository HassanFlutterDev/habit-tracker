import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:timebloc/model/event.dart';
import 'package:timebloc/model/tag.dart';
import 'package:timebloc/utils/utils.dart';

@entity
class Routine {
  @primaryKey
  int? id;
  String name;
  bool isEnabled;

  @ignore
  List<Event> events = [];

  Routine({this.id, required this.name, this.isEnabled = true});
}
