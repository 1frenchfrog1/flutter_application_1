// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('home offers todo, checklist, and cooklist services', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: TodoLandingPage(directory: Directory.systemTemp)),
    );

    expect(find.text('Mes todo-list'), findsOneWidget);
    expect(find.text('Mes checklists'), findsOneWidget);
    expect(find.text('Mes Cooklists'), findsOneWidget);
    expect(find.text('Ouvrir le catalogue d’icônes'), findsNothing);
  });
}
