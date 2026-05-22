import 'package:fitai/app/app.dart';
import 'package:fitai/app/routes.dart';
import 'package:fitai/features/anamnesis/presentation/anamnesis_screen.dart';
import 'package:fitai/features/auth/presentation/auth_screen.dart';
import 'package:fitai/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts on the FitAI splash route', (WidgetTester tester) async {
    await tester.pumpWidget(const FitAiApp());

    expect(find.text('FitAI'), findsOneWidget);
  });

  testWidgets('shows the onboarding introduction', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: OnboardingScreen()),
    );

    expect(find.text('Seu treino, do seu jeito'), findsOneWidget);
    expect(find.text('Comece ja'), findsOneWidget);
  });

  testWidgets('shows the visual auth form', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AuthScreen()),
    );

    expect(find.text('Bem vindo de volta!'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Cadastre-se'), findsOneWidget);
  });

  testWidgets('switches from login to visual sign up', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: AuthScreen()),
    );

    await tester.tap(find.text('Cadastre-se'));
    await tester.pumpAndSettle();

    expect(find.text('Crie sua conta'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Confirmar senha'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
  });

  testWidgets('shows the initial anamnesis fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AnamnesisScreen()),
    );

    expect(find.text('Anamnese inicial'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Dias disponiveis'), findsOneWidget);
    expect(find.text('Lesoes ou restricoes'), findsOneWidget);
  });

  testWidgets('finishes onboarding on the visual auth route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.onboarding,
        routes: AppRoutes.builders,
      ),
    );

    await tester.tap(find.text('Comece ja'));
    await tester.pumpAndSettle();

    expect(find.text('Bem vindo de volta!'), findsOneWidget);
  });

  testWidgets('continues from visual auth to anamnesis', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.login,
        routes: AppRoutes.builders,
      ),
    );

    await tester.tap(find.text('Entrar').last);
    await tester.pumpAndSettle();

    expect(find.text('Anamnese inicial'), findsOneWidget);
  });
}
