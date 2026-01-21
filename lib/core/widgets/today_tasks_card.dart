import 'package:flutter/material.dart';
import '../../models/daily_task.dart';
import '../constants/app_colors.dart';

class TodayTasksCard extends StatelessWidget {
  final List<DailyTask> tasks;

  const TodayTasksCard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Aujourd’hui",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            ...tasks.map(
                  (task) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const Icon(Icons.eco, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(child: Text(task.title)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}