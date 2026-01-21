import 'package:flutter/material.dart';
import '../../models/personal_task.dart';
import '../../utils/storage_service.dart';
import '../../pages/day_notes_page.dart';
import '../calendar/day_selector.dart';
import '../calendar/month_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  List<PersonalTask> tasks = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      tasks = StorageService.getPersonalTasks();
      setState(() {});
    });
  }

  void toggleTask(int index, bool? value) {
    setState(() {
      tasks[index].completed = value ?? false;
      StorageService.updatePersonalTask(index, tasks[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth =
    DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendrier de survie'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            MonthSelector(
              selectedDate: selectedDate,
              onChanged: (date) => setState(() {
                selectedDate = date;
              }),
            ),
            const SizedBox(height: 10),
            DaySelector(
              selectedDate: selectedDate,
              onChanged: (date) => setState(() {
                selectedDate = date;
              }),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: daysInMonth,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final dayDate = DateTime(
                      selectedDate.year, selectedDate.month, day);

                  // Vérifie si des tâches existent pour ce jour
                  final hasTasks = tasks.any((t) =>
                  t.completed == false); // Ici on peut lier plus tard à StorageService pour les tasks spécifiques

                  return GestureDetector(
                    onTap: () {
                      // Ouvre la page des notes du jour
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DayNotesPage(date: dayDate),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getDayColor(selectedDate),
                        borderRadius: BorderRadius.circular(8),
                        border: hasTasks
                            ? Border.all(color: Colors.redAccent, width: 2)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDayColor(DateTime date) {
    final month = date.month;
    if (month >= 3 && month <= 5) return Colors.green; // Printemps
    if (month >= 6 && month <= 8) return Colors.orange; // Été
    if (month >= 9 && month <= 11) return Colors.brown; // Automne
    return Colors.blue; // Hiver
  }
}