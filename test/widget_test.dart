import 'package:fitai/app/app.dart';
import 'package:fitai/app/routes.dart';
import 'package:fitai/features/anamnesis/presentation/anamnesis_screen.dart';
import 'package:fitai/features/auth/presentation/auth_screen.dart';
import 'package:fitai/features/home/presentation/home_screen.dart';
import 'package:fitai/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitai/features/workout/presentation/workout_screen.dart';
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

    expect(find.text('Seus aspectos fisicos'), findsOneWidget);
    expect(find.text('Idade'), findsOneWidget);
    expect(find.text('Limitacoes Fisicas'), findsOneWidget);
    expect(find.text('Marque seu objetivo'), findsOneWidget);
  });

  testWidgets('shows the workout agenda on home', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text('Agenda de Treino'), findsOneWidget);
    expect(find.text('Dia 1'), findsOneWidget);
    expect(find.text('Treino A - Peito e triceps'), findsOneWidget);
    expect(find.text('TREINOS'), findsOneWidget);
  });

  testWidgets('shows the simple workout screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: WorkoutScreen()),
    );

    expect(find.text('Treino Simples'), findsOneWidget);
    expect(find.text('Supino reto'), findsOneWidget);
    expect(find.text('Series'), findsWidgets);
    expect(find.text('Iniciar treino'), findsOneWidget);
  });

  testWidgets('registers a set on the workout screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: WorkoutScreen()),
    );

    expect(find.text('0/4'), findsOneWidget);

    await tester.tap(find.text('Registrar serie').first);
    await tester.pumpAndSettle();

    expect(find.text('Carga utilizada'), findsOneWidget);
    expect(find.text('Repeticoes'), findsOneWidget);

    await tester.tap(find.text('Salvar serie'));
    await tester.pumpAndSettle();

    expect(find.text('1/4'), findsOneWidget);
    expect(find.text('Finalizar treino'), findsOneWidget);
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

    expect(find.text('Seus aspectos fisicos'), findsOneWidget);
  });
}
