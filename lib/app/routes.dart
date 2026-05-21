import 'package:fitai/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const anamnesis = '/anamnesis';
  static const home = '/home';
  static const workout = '/workout';
  static const progress = '/progress';
  static const profile = '/profile';

  static final Map<String, WidgetBuilder> builders = {
    splash: (_) => const SplashScreen(),
  };
}
