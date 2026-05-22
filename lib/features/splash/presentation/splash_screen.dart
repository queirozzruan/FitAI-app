import 'dart:async';

import 'package:fitai/app/routes.dart';
import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer _transitionTimer;

  @override
  void initState() {
    super.initState();
    _transitionTimer = Timer(_splashDuration, _openOnboarding);
  }

  @override
  void dispose() {
    _transitionTimer.cancel();
    super.dispose();
  }

  void _openOnboarding() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: FitAiColors.white.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadius.circular(28),
                        color: FitAiColors.white,
                      ),
                      child: const Icon(
                        Icons.fitness_center_rounded,
                        color: FitAiColors.royalBlue,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'FitAI',
                      style: Theme.of(context).textTheme.displaySmall
                          ?.copyWith(
                            color: FitAiColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Seu treino, organizado.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: FitAiColors.white.withValues(alpha: 0.86),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.lg),
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      color: FitAiColors.white,
                      strokeWidth: 2.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _splashDuration = Duration(milliseconds: 1200);
