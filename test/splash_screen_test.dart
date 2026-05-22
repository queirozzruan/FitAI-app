import 'package:fitai/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('moves from splash to onboarding after the loading delay', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FitAiApp());

    expect(find.text('SEU TREINO COM IA'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    expect(find.text('Seu treino, do seu jeito'), findsOneWidget);
  });
}
