import 'package:flutter_test/flutter_test.dart';
import 'package:homecheck_app/app/app.dart';

void main() {
  testWidgets('HomeCheck app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const HomeCheckApp());

    expect(find.text('HomeCheck'), findsOneWidget);
  });
}
