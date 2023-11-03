import 'package:calcubon/views/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UI Test for ReportPage', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ReportPage(),
    ));

    // Verify that the text "Report" is displayed.
    expect(find.text('Report'), findsOneWidget);

    // Verify that the CircularProgressIndicator is not displayed.
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // You can continue to add more test cases based on your UI elements.
  });
}
