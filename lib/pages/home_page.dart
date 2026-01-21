import 'package:flutter/material.dart';
import 'calendar/calendar_flo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accueil')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarFloPage()),
            );
          },
          child: const Text('Ouvrir le Calendrier'),
        ),
      ),
    );
  }
}