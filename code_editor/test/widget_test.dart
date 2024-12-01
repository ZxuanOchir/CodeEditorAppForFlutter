// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:code_text_field/code_text_field.dart';

import 'package:code_editor/main.dart';

void main() {
  testWidgets('Code editor basic test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MyClass()));

    // Verify that the code editor is present
    expect(find.byType(CodeField), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_sharp), findsOneWidget);
  });
}
