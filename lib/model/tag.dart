import 'package:floor/floor.dart';

@entity
class Tag {
  @PrimaryKey(autoGenerate: true)
  int? id;
  late String name;
  late String color;

  Tag({required this.name, required this.color, this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color,
    };
  }

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }
}
