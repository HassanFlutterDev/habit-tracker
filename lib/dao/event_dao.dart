import 'package:floor/floor.dart';
import 'package:timebloc/model/event.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  @Query('SELECT * FROM Event WHERE date = :date AND routineId is null')
  Future<List<Event>> findAllEventsByDate(String date);

  @Query('SELECT * FROM Event WHERE date = :date')
  Future<List<Event>> getAllEventsByDate(String date);

  @Query('SELECT name FROM Event')
  Stream<List<String>> findAllEventName();

  @Query('SELECT * FROM Event WHERE routineId = :id')
  Future<List<Event>> findAllEventsByRoutine(int id);

  @Query('SELECT * FROM Event WHERE id = :id')
  Stream<Event?> findEventById(int id);

  @Query('DELETE FROM Event WHERE routineId = :id')
  Future<void> deleteByRoutineId(int id);

  @insert
  Future<void> insertEvent(Event event);

  @update
  Future<void> updateEvent(Event event);
}
