import 'package:floor/floor.dart';
import 'package:timebloc/model/event.dart';

import '../model/routine.dart';
import '../model/tag.dart';

@dao
abstract class RoutineDao {
  @Query('SELECT * FROM Routine')
  Future<List<Routine>> findAllRoutines();

  // @Query('SELECT * FROM Tag')
  // Future<List<Map<String, dynamic>>> findAllTagsV2();

  @Query('SELECT name FROM Routine')
  Stream<List<String>> findAllRoutineName();

  @Query('SELECT * FROM Routine WHERE id = :id')
  Stream<Routine?> findTagById(int id);

  @insert
  Future<void> insertRoutine(Routine tag);

  @update
  Future<void> updateRoutie(Routine tag);

  @delete
  Future<void> deleteRoutine(Routine tag);
}
