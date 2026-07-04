import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homecheck_app/app/app.dart';
import 'package:homecheck_app/features/authentication/presentation/screens/login_screen.dart';

void main() {
  testWidgets('unauthenticated user is redirected to login screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: HomeCheckApp(),
      ),
    );

    expect(find.text('HomeCheck'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}