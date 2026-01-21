import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const DaySelector({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(selectedDate.year, selectedDate.month);

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final day = index + 1;
          final isSelected = day == selectedDate.day;
          final dayDate = DateTime(selectedDate.year, selectedDate.month, day);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            width: 50,
            decoration: BoxDecoration(
              color: isSelected ? _getDayColor(selectedDate) : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [BoxShadow(color: _getDayColor(selectedDate).withOpacity(0.4), blurRadius: 6, offset: const Offset(0, 3))]
                  : [],
            ),
            child: GestureDetector(
              onTap: () => onChanged(dayDate),
              child: Center(
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
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