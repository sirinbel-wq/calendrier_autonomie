import 'package:hive/hive.dart';

part 'day_note.g.dart';

@HiveType(typeId: 0)
class DayNote {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  String text;

  @HiveField(2)
  String? imagePath;

  DayNote({required this.date, required this.text, this.imagePath});
}