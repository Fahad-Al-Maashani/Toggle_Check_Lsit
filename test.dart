import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Toggle items and verify progress updates',
      (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const ToggleListApp());
    await tester.pumpAndSettle();

    // Verify initial state: No items, progress bar should be at 0%.
    expect(find.byType(ListTile), findsNothing);
    expect(find.text('Progress: 0%'), findsOneWidget);

    // Add a new item to the list.
    await tester.enterText(find.byType(TextField), 'Visit Eiffel Tower');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Ensure the item appears in the list.
    expect(find.text('Visit Eiffel Tower'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);

    // Toggle the switch for the added item.
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // Verify that the progress has increased.
    expect(find.text('Progress: 100%'), findsOneWidget);
  });
}
