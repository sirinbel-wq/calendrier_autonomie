import 'package:flutter/material.dart';

class MonthSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const MonthSelector({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final month = months[index];
          final isSelected = index + 1 == selectedDate.month;
          final monthColor = _getMonthColor(index + 1);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? monthColor : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [BoxShadow(color: monthColor.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))]
                  : [],
            ),
            child: GestureDetector(
              onTap: () {
                onChanged(DateTime(DateTime.now().year, index + 1));
              },
              child: Center(
                child: Text(
                  month,
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

  Color _getMonthColor(int month) {
    if (month >= 3 && month <= 5) return Colors.green; // Printemps
    if (month >= 6 && month <= 8) return Colors.orange; // Été
    if (month >= 9 && month <= 11) return Colors.brown; // Automne
    return Colors.blue; // Hiver
  }
}