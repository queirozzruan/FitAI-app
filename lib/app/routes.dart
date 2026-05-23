import 'package:fitai/features/anamnesis/presentation/anamnesis_screen.dart';
import 'package:fitai/features/auth/presentation/auth_screen.dart';
import 'package:fitai/features/home/presentation/home_screen.dart';
import 'package:fitai/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitai/features/progress/presentation/progress_profile_screen.dart';
import 'package:fitai/features/splash/presentation/splash_screen.dart';
import 'package:fitai/features/workout/presentation/workout_screen.dart';
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
    onboarding: (context) => OnboardingScreen(
      onFinished: () {
        Navigator.of(context).pushReplacementNamed(login);
      },
    ),
    login: (context) => AuthScreen(
      onContinue: () {
        Navigator.of(context).pushReplacementNamed(anamnesis);
      },
    ),
    anamnesis: (context) => AnamnesisScreen(
      onContinue: () {
        Navigator.of(context).pushReplacementNamed(home);
      },
    ),
    home: (context) => HomeScreen(
      onProgressTap: () {
        Navigator.of(context).pushReplacementNamed(progress);
      },
      onWorkoutSelected: (_) {
        Navigator.of(context).pushNamed(workout);
      },
    ),
    progress: (context) => ProgressProfileScreen(
      onWorkoutsTap: () {
        Navigator.of(context).pushReplacementNamed(home);
      },
    ),
    workout: (context) => WorkoutScreen(
      onBack: () {
        Navigator.of(context).pop();
      },
    ),
  };
}
