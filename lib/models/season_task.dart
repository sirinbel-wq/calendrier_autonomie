import 'package:hive/hive.dart';

part 'season_task.g.dart';

@HiveType(typeId: 1)
class SeasonTask extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? category;

  @HiveField(2)
  bool completed; // nouveau champ ajouté

  SeasonTask({
    required this.title,
    this.category,
    this.completed = false,
  });
}