import 'package:flutter/material.dart';
import '../../models/personal_task.dart';
class TaskList extends StatelessWidget {
  final List<PersonalTask> tasks;
  final Function(int, bool?) onCheck;

  const TaskList({
    Key? key,
    required this.tasks,
    required this.onCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((task) {
        int index = tasks.indexOf(task);
        return CheckboxListTile(
          value: task.completed,
          title: Text(task.title),
          subtitle: Text('${task.category} • ${task.season}'),
          onChanged: (value) => onCheck(index, value),
        );
      }).toList(),
    );
  }
}