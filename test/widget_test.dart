import 'package:flutter_test/flutter_test.dart';
import 'package:kickin/app.dart';

void main() {
  testWidgets('Kickin app boots without crashing', (WidgetTester tester) async {
    // Build the Kickin app
    await tester.pumpWidget(const KickinApp());

    // Let first frame settle
    await tester.pumpAndSettle();

    // Basic sanity check: app renders something
    expect(find.byType(KickinApp), findsOneWidget);
  });
}
