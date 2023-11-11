// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_bloc_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTimeBlocDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TimeBlocDatabaseBuilder databaseBuilder(String name) =>
      _$TimeBlocDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TimeBlocDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TimeBlocDatabaseBuilder(null);
}

class _$TimeBlocDatabaseBuilder {
  _$TimeBlocDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TimeBlocDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TimeBlocDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TimeBlocDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TimeBlocDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TimeBlocDatabase extends TimeBlocDatabase {
  _$TimeBlocDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EventDao? _eventDaoInstance;

  RoutineDao? _routineDaoInstance;

  TagDao? _tagDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`id` INTEGER, `date` TEXT NOT NULL, `startTime` TEXT NOT NULL, `endTime` TEXT NOT NULL, `image` TEXT NOT NULL, `name` TEXT NOT NULL, `color` TEXT NOT NULL, `isImageImojie` INTEGER NOT NULL, `tags` TEXT NOT NULL, `routineDays` TEXT, `routineId` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Tag` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `color` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Routine` (`id` INTEGER, `name` TEXT NOT NULL, `isEnabled` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }

  @override
  RoutineDao get routineDao {
    return _routineDaoInstance ??= _$RoutineDao(database, changeListener);
  }

  @override
  TagDao get tagDao {
    return _tagDaoInstance ??= _$TagDao(database, changeListener);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'image': item.image,
                  'name': item.name,
                  'color': item.color,
                  'isImageImojie': item.isImageImojie ? 1 : 0,
                  'tags': item.tags,
                  'routineDays': item.routineDays,
                  'routineId': item.routineId
                },
            changeListener),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'Event',
            ['id'],
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'image': item.image,
                  'name': item.name,
                  'color': item.color,
                  'isImageImojie': item.isImageImojie ? 1 : 0,
                  'tags': item.tags,
                  'routineDays': item.routineDays,
                  'routineId': item.routineId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  @override
  Future<List<Event>> findAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            routineDays: row['routineDays'] as String?,
            name: row['name'] as String,
            endTime: row['endTime'] as String,
            image: row['image'] as String,
            color: row['color'] as String,
            isImageImojie: (row['isImageImojie'] as int) != 0,
            tags: row['tags'] as String,
            routineId: row['routineId'] as int?));
  }

  @override
  Future<List<Event>> findAllEventsByDate(String date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Event WHERE date = ?1 AND routineId is null',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            routineDays: row['routineDays'] as String?,
            name: row['name'] as String,
            endTime: row['endTime'] as String,
            image: row['image'] as String,
            color: row['color'] as String,
            isImageImojie: (row['isImageImojie'] as int) != 0,
            tags: row['tags'] as String,
            routineId: row['routineId'] as int?),
        arguments: [date]);
  }

  @override
  Future<List<Event>> getAllEventsByDate(String date) async {
    return _queryAdapter.queryList('SELECT * FROM Event WHERE date = ?1',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            routineDays: row['routineDays'] as String?,
            name: row['name'] as String,
            endTime: row['endTime'] as String,
            image: row['image'] as String,
            color: row['color'] as String,
            isImageImojie: (row['isImageImojie'] as int) != 0,
            tags: row['tags'] as String,
            routineId: row['routineId'] as int?),
        arguments: [date]);
  }

  @override
  Stream<List<String>> findAllEventName() {
    return _queryAdapter.queryListStream('SELECT name FROM Event',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Event',
        isView: false);
  }

  @override
  Future<List<Event>> findAllEventsByRoutine(int id) async {
    return _queryAdapter.queryList('SELECT * FROM Event WHERE routineId = ?1',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            routineDays: row['routineDays'] as String?,
            name: row['name'] as String,
            endTime: row['endTime'] as String,
            image: row['image'] as String,
            color: row['color'] as String,
            isImageImojie: (row['isImageImojie'] as int) != 0,
            tags: row['tags'] as String,
            routineId: row['routineId'] as int?),
        arguments: [id]);
  }

  @override
  Stream<Event?> findEventById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Event WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            date: row['date'] as String,
            startTime: row['startTime'] as String,
            routineDays: row['routineDays'] as String?,
            name: row['name'] as String,
            endTime: row['endTime'] as String,
            image: row['image'] as String,
            color: row['color'] as String,
            isImageImojie: (row['isImageImojie'] as int) != 0,
            tags: row['tags'] as String,
            routineId: row['routineId'] as int?),
        arguments: [id],
        queryableName: 'Event',
        isView: false);
  }

  @override
  Future<void> deleteByRoutineId(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Event WHERE routineId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvent(Event event) async {
    await _eventUpdateAdapter.update(event, OnConflictStrategy.abort);
  }
}

class _$RoutineDao extends RoutineDao {
  _$RoutineDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _routineInsertionAdapter = InsertionAdapter(
            database,
            'Routine',
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEnabled': item.isEnabled ? 1 : 0
                },
            changeListener),
        _routineUpdateAdapter = UpdateAdapter(
            database,
            'Routine',
            ['id'],
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEnabled': item.isEnabled ? 1 : 0
                },
            changeListener),
        _routineDeletionAdapter = DeletionAdapter(
            database,
            'Routine',
            ['id'],
            (Routine item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEnabled': item.isEnabled ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Routine> _routineInsertionAdapter;

  final UpdateAdapter<Routine> _routineUpdateAdapter;

  final DeletionAdapter<Routine> _routineDeletionAdapter;

  @override
  Future<List<Routine>> findAllRoutines() async {
    return _queryAdapter.queryList('SELECT * FROM Routine',
        mapper: (Map<String, Object?> row) => Routine(
            id: row['id'] as int?,
            name: row['name'] as String,
            isEnabled: (row['isEnabled'] as int) != 0));
  }

  @override
  Stream<List<String>> findAllRoutineName() {
    return _queryAdapter.queryListStream('SELECT name FROM Routine',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Routine',
        isView: false);
  }

  @override
  Stream<Routine?> findTagById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Routine WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Routine(
            id: row['id'] as int?,
            name: row['name'] as String,
            isEnabled: (row['isEnabled'] as int) != 0),
        arguments: [id],
        queryableName: 'Routine',
        isView: false);
  }

  @override
  Future<void> insertRoutine(Routine tag) async {
    await _routineInsertionAdapter.insert(tag, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRoutie(Routine tag) async {
    await _routineUpdateAdapter.update(tag, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRoutine(Routine tag) async {
    await _routineDeletionAdapter.delete(tag);
  }
}

class _$TagDao extends TagDao {
  _$TagDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _tagInsertionAdapter = InsertionAdapter(
            database,
            'Tag',
            (Tag item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'color': item.color
                },
            changeListener),
        _tagUpdateAdapter = UpdateAdapter(
            database,
            'Tag',
            ['id'],
            (Tag item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'color': item.color
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Tag> _tagInsertionAdapter;

  final UpdateAdapter<Tag> _tagUpdateAdapter;

  @override
  Future<List<Tag>> findAllTags() async {
    return _queryAdapter.queryList('SELECT * FROM Tag',
        mapper: (Map<String, Object?> row) => Tag(
            name: row['name'] as String,
            color: row['color'] as String,
            id: row['id'] as int?));
  }

  @override
  Stream<List<String>> findAllTagName() {
    return _queryAdapter.queryListStream('SELECT name FROM Tag',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        queryableName: 'Tag',
        isView: false);
  }

  @override
  Stream<Tag?> findTagById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Tag WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Tag(
            name: row['name'] as String,
            color: row['color'] as String,
            id: row['id'] as int?),
        arguments: [id],
        queryableName: 'Tag',
        isView: false);
  }

  @override
  Future<void> insertTag(Tag tag) async {
    await _tagInsertionAdapter.insert(tag, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTag(Tag tag) async {
    await _tagUpdateAdapter.update(tag, OnConflictStrategy.abort);
  }
}
