// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labyrinth/firebase/firebase_authentification.dart';
import 'package:labyrinth/login/login_page.dart';

import 'package:labyrinth/main.dart';
import 'package:labyrinth/splash/splash_page.dart';

void main() {
  group("Test Firebase", () {
    setUp(() {});

    test("Test Firebase apps", () {
      expect(Firebase.apps != null, true);
    });

    test("Verify if user is authorized", () {
      // expect(FirebaseAuthentification().getCurrUser() != null, true);
    });
  });

  testWidgets('Test MatterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(SplashPage), findsOneWidget);
  });
}
