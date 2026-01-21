import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('tasksBox');      // PersonalTask
  await Hive.openBox('dayNotesBox');   // DayNote
  await Hive.openBox('season_tasks');  // SeasonTask
  await Hive.openBox('recipesBox');    // Recipe

  runApp(const MyApp());
}