// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_machine_task/main.dart';
import 'package:flutter_machine_task/presentation/screens/login_page/widgets/login_form.dart';

void main() {
  testWidgets('BeeChemApp shows login form', (WidgetTester tester) async {
    await tester.pumpWidget(const BeeChemApp());
    await tester.pumpAndSettle();

    expect(find.byType(LoginForm), findsOneWidget);
  });
}
