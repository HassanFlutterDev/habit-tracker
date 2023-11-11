import 'package:shared_preferences/shared_preferences.dart';
import 'package:timebloc/utils/utils.dart';

import 'database/time_bloc_database.dart';
import 'model/tag.dart';

late final TimeBlocDatabase timeBlockDatabase;
late final SharedPreferences sharedPreferences;

initApp() async {
  timeBlockDatabase =
      await $FloorTimeBlocDatabase.databaseBuilder('app_database.db').build();
  sharedPreferences = await SharedPreferences.getInstance();

  bool? isInit = sharedPreferences.getBool("is_init");
  if (isInit == null || !isInit) {
    List<Tag> tags = [];
    tags.add(Tag(name: "Leisure", color: colorList[0]));
    tags.add(Tag(name: "Meal", color: colorList[1]));
    tags.add(Tag(name: "Commute", color: colorList[2]));
    tags.add(Tag(name: "Study", color: colorList[3]));
    tags.add(Tag(name: "Work", color: colorList[4]));
    tags.add(Tag(name: "Chores", color: colorList[5]));
    tags.add(Tag(name: "Break", color: colorList[6]));
    tags.add(Tag(name: "Exercise", color: colorList[7]));
    for (Tag tag in tags) {
      await timeBlockDatabase.tagDao.insertTag(tag);
    }
    sharedPreferences.setBool("is_init", true);
  }
}
