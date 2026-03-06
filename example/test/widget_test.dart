// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:smart_flutter_validator_example/main.dart';

void main() {
  testWidgets('Switch locale and see localized validation', (tester) async {
    await tester.pumpWidget(const ExampleApp());
    await tester.pumpAndSettle();

    // Open the language menu and pick Español.
    await tester.tap(find.byTooltip('Validation language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();

    // Preview card should update immediately.
    expect(find.text('Este campo es obligatorio'), findsWidgets);

    // Trigger validation with empty fields.
    await tester.tap(find.text('Sign in'), warnIfMissed: false);
    await tester.pumpAndSettle();

    // Required message should appear for at least one field.
    expect(find.text('Este campo es obligatorio'), findsWidgets);
  });
}
