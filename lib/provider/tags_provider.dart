import 'package:flutter/material.dart';
import 'package:timebloc/init_app.dart';

import '../model/tag.dart';

class TagsProvider extends ChangeNotifier {
  List<Tag> tags = [];

  Future<bool> addTag(Tag tag) async {
    await timeBlockDatabase.tagDao.insertTag(tag);
    getTags();
    return true;
  }
  Future<bool> updateTag(Tag tag) async {
    print("Update"+tag.id.toString());
    print("Update"+tag.name.toString());
    await timeBlockDatabase.tagDao.updateTag(tag);
    getTags();
    return true;
  }

  void getTags() async {
    tags = await timeBlockDatabase.tagDao.findAllTags();
    // List<Map<String , dynamic>> jsons = await timeBlockDatabase.tagDao.findAllTagsV2();
    //
    // jsons.forEach((element) {
    //
    //   print(element.toString());
    //
    // });
    notifyListeners();
  }
}
