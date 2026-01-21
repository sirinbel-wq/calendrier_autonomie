import 'package:flutter/material.dart';
import '../../models/daily_task.dart';
import '../../core/widgets/today_tasks_card.dart';
import 'month_selector.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  final Map<DateTime, List<DailyTask>> dailyTasks = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      DailyTask(
          title: 'Observer le potager',
          category: 'Permaculture',
          description: 'Surveiller humidité et jeunes pousses'),
    ],
  };

  Color _seasonColor(int month) {
    if (month >= 3 && month <= 5) return Colors.green.shade300;
    if (month >= 6 && month <= 8) return Colors.orange.shade300;
    if (month >= 9 && month <= 11) return Colors.brown.shade300;
    return Colors.blue.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final year = selectedDate.year;
    final month = selectedDate.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendrier Premium Animé'),
          centerTitle: true,
        ),
        body: Column(
          children: [
          MonthSelector(
          selectedDate: selectedDate,
          onChanged: (date) => setState(() => selectedDate = date),
        ),
        const SizedBox(height: 8),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                    itemCount: daysInMonth,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      final date = DateTime(year, month, day);
                      final isSelected = day == selectedDate.day;
                      final hasTask = dailyTasks[date]?.isNotEmpty ?? false;

                      return InkWell(
                          onTap: () => setState(() => selectedDate = date),
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.deepPurple : _seasonColor(month),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Colors.purple : Colors.grey.shade400,
                                width: 1.5,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                Text(
                                day.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          Positioned(
                            bottom: 6,
                            child: hasTask
                                ? Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            )
                                : const SizedBox.shrink(),
                          ),
                                ],
                            ),
                          ),
                      );
                    },
                ),
            ),
        ),
            const SizedBox(height: 12),
            Expanded(
              child: TodayTasksCard(
                tasks: dailyTasks[selectedDate] ?? [],
              ),
            ),
          ],
        ),
    );
  }
}