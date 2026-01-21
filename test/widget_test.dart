import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calendrier/app.dart';

void main() {
  testWidgets('L\'application démarre sans erreur', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Vérifie que l'écran principal existe
    expect(find.byType(Scaffold), findsOneWidget);
  });
}