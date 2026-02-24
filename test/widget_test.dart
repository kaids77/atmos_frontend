import 'package:flutter_test/flutter_test.dart';
import 'package:atmos_frontend/main.dart';

void main() {
  testWidgets('Splash screen loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const AtmosApp());

    // Verify Atmos text appears
    expect(find.text('Atmos'), findsOneWidget);

    // Verify subtitle appears
    expect(find.text('Smart Weather Forecast & AI Planner'), findsOneWidget);
  });
}
