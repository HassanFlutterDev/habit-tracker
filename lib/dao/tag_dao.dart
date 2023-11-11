import 'package:floor/floor.dart';
import 'package:timebloc/model/event.dart';

import '../model/tag.dart';

@dao
abstract class TagDao {
  @Query('SELECT * FROM Tag')
  Future<List<Tag>> findAllTags();

  // @Query('SELECT * FROM Tag')
  // Future<List<Map<String, dynamic>>> findAllTagsV2();

  @Query('SELECT name FROM Tag')
  Stream<List<String>> findAllTagName();

  @Query('SELECT * FROM Tag WHERE id = :id')
  Stream<Tag?> findTagById(int id);

  @insert
  Future<void> insertTag(Tag tag);

  @update
  Future<void> updateTag(Tag tag);
}
