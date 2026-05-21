import 'package:fitai/app/routes.dart';
import 'package:fitai/app/theme.dart';
import 'package:flutter/material.dart';

class FitAiApp extends StatelessWidget {
  const FitAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.builders,
      theme: FitAiTheme.light,
      title: 'FitAI',
    );
  }
}
