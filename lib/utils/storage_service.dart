import 'package:hive/hive.dart';
import '../models/day_note.dart';
import '../models/season_task.dart';
import '../models/recipe.dart';

class StorageService {
  static Box<DayNote> get dayNotesBox => Hive.box<DayNote>('dayNotesBox');
  static Box<SeasonTask> get seasonTasksBox => Hive.box<SeasonTask>('season_tasks');
  static Box<Recipe> get recipesBox => Hive.box<Recipe>('recipesBox');

  static List<DayNote> getDayNotes(DateTime date) {
    final allNotes = dayNotesBox.values.toList();
    return allNotes.where((note) =>
    note.date.year == date.year &&
        note.date.month == date.month &&
        note.date.day == date.day
    ).toList();
  }

  static void saveDayNote(DayNote note) {
    dayNotesBox.add(note);
  }

  static List<SeasonTask> getSeasonTasks(String season) {
    return seasonTasksBox.values
        .where((task) => task.season == season)
        .toList();
  }

  static void saveSeasonTask(SeasonTask task) {
    seasonTasksBox.add(task);
  }

  static List<Recipe> getRecipes({String? season, String? category}) {
    var allRecipes = recipesBox.values.toList();
    if (season != null) {
      allRecipes = allRecipes.where((r) => r.season == season).toList();
    }
    if (category != null) {
      allRecipes = allRecipes.where((r) => r.category == category).toList();
    }
    return allRecipes;
  }

  static void saveRecipe(Recipe recipe) {
    recipesBox.add(recipe);
  }
}