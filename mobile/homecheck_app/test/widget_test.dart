import 'package:flutter_test/flutter_test.dart';
import 'package:homecheck_app/app/app.dart';

void main() {
  testWidgets('HomeCheck starts on splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeCheckApp());
    await tester.pumpAndSettle();

    expect(find.text('HomeCheck'), findsOneWidget);
    expect(find.text('Go to Login'), findsOneWidget);
  });
}
