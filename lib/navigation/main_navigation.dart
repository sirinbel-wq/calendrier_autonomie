import 'package:flutter/material.dart';
import 'package:calendrier/core/theme/app_theme.dart';
import 'package:calendrier/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:  appTheme(),
      home: const MyApp(),
    );
  }
}