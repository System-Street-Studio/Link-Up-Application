import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_up/screens/login_page.dart';

void main() {
  testWidgets('LoginPage shows fields and login button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Tapping login with empty fields shows validation SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.tap(find.text('Login'));
    // Start frames and let the mock network delay finish (1s)
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Please enter email and password'), findsOneWidget);
  });

  testWidgets('Successful login shows logged in SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;

    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'hunter2');

    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Logged in as test@example.com'), findsOneWidget);
  });
}
