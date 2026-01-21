import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/day_note.dart';
import '../../models/season_task.dart';
import '../../utils/storage_service.dart';
import '../../pages/day_notes_page.dart';
import '../../pages/season_detail_page.dart';

class CalendarFloPage extends StatefulWidget {
  const CalendarFloPage({super.key});

  @override
  State<CalendarFloPage> createState() => _CalendarFloPageState();
}

class _CalendarFloPageState extends State<CalendarFloPage> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDay;
  String? _filterCategory;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentMonth.year * 12 + (_currentMonth.month - 1),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ===================== Génération des jours =====================
  List<DateTime> _daysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);

    final days = <DateTime>[];

    for (int i = 0; i < firstDay.weekday - 1; i++) {
      days.add(DateTime(0));
    }

    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(date.year, date.month, i));
    }

    return days;
  }

  Color _seasonColor(DateTime date) {
    final m = date.month;
    if (m >= 3 && m <= 5) return Colors.green;
    if (m >= 6 && m <= 8) return Colors.orange;
    if (m >= 9 && m <= 11) return Colors.brown;
    return Colors.blueGrey;
  }

  String _seasonFromDate(DateTime date) {
    final m = date.month;
    if (m >= 3 && m <= 5) return 'printemps';
    if (m >= 6 && m <= 8) return 'été';
    if (m >= 9 && m <= 11) return 'automne';
    return 'hiver';
  }

  bool _hasNote(DateTime date) {
    final notes = StorageService.getDayNotes(date);
    if (_filterCategory != null) {
      return notes.any((n) => n.text.toLowerCase().contains(_filterCategory!.toLowerCase()));
    }
    return notes.isNotEmpty;
  }

  bool _hasTask(DateTime date) {
    final tasks = StorageService.getSeasonTasks(_seasonFromDate(date));
    if (_filterCategory != null) {
      return tasks.any((t) => t.category?.toLowerCase() == _filterCategory!.toLowerCase());
    }
    return tasks.isNotEmpty;
  }

  void _selectDay(DateTime day) {
    setState(() => _selectedDay = day);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DayNotesPage(date: day)),
    );
  }

  void _openSeason(String season) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SeasonDetailPage(season: season)),
    );
  }

  void _setFilter(String? category) {
    setState(() {
      _filterCategory = category;
    });
  }

  // ===================== UI =====================
  @override
  Widget build(BuildContext context) {
    final color = _seasonColor(_currentMonth);

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat.yMMMM('fr_FR').format(_currentMonth)),
        backgroundColor: color,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // ===== Boutons saisons =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _seasonButton('Printemps'),
                _seasonButton('Été'),
                _seasonButton('Automne'),
                _seasonButton('Hiver'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== Filtres =====
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _filterButton('Permaculture'),
                _filterButton('Apiculture'),
                _filterButton('Autonomie'),
                _filterButton('Recettes'),
                _filterButton('Tout voir'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== Jours de la semaine =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                .map((d) => Text(d, style: TextStyle(fontWeight: FontWeight.bold)))
                .toList(),
          ),

          const SizedBox(height: 8),

          // ===== Grille calendrier avec swipe horizontal =====
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  final year = index ~/ 12;
                  final month = (index % 12) + 1;
                  final monthDate = DateTime(year, month, 1);
                });
              },
              itemBuilder: (context, index) {
                final year = index ~/ 12;
                final month = index % 12;
                final monthDate = DateTime(year, month == 0 ? 12 : month, 1);
                final days = _daysInMonth(monthDate);
                final seasonColor = _seasonColor(monthDate);

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: days.length,
                  itemBuilder: (context, idx) {
                    final day = days[idx];
                    if (day.year == 0) return const SizedBox.shrink();

                    final isSelected = _selectedDay != null &&
                        day.year == _selectedDay!.year &&
                        day.month == _selectedDay!.month &&
                        day.day == _selectedDay!.day;

                    final hasNote = _hasNote(day);
                    final hasTask = _hasTask(day);
                    final isToday =
                        day.year == DateTime.now().year &&
                            day.month == DateTime.now().month &&
                            day.day == DateTime.now().day;

                    return GestureDetector(
                      onTap: () => _selectDay(day),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: isSelected ? seasonColor : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: isToday
                              ? Border.all(color: seasonColor, width: 2)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                            if (hasNote)
                              Positioned(
                                bottom: 4,
                                left: 8,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            if (hasTask)
                              Positioned(
                                bottom: 4,
                                right: 8,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // ===== Zone info jour sélectionné =====
          if (_selectedDay != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Jour sélectionné : ${DateFormat.yMMMMd('fr_FR').format(_selectedDay!)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }

  Widget _seasonButton(String season) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () => _openSeason(season.toLowerCase()),
        child: Text(season),
      ),
    );
  }

  Widget _filterButton(String category) {
    final isSelected = (_filterCategory == category) || (category == 'Tout voir' && _filterCategory == null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blueGrey : Colors.grey[300],
        ),
        onPressed: () => _setFilter(category == 'Tout voir' ? null : category),
        child: Text(category, style: TextStyle(color: isSelected ? Colors.white : Colors.black87)),
      ),
    );
  }
}