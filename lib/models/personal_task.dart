import 'package:hive/hive.dart';

part 'personal_task.g.dart'; // obligatoire pour Hive

@HiveType(typeId: 2) // typeId unique
class PersonalTask extends HiveObject {
  @HiveField(0) // numéro unique
  String title;

  @HiveField(1) // numéro unique
  String? category;

  @HiveField(2) // nouveau champ pour suivi
  bool completed;

  PersonalTask({
    required this.title,
    this.category,
    this.completed = false,
  });
}