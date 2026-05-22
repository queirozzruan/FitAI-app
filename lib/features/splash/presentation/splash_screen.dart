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
      backgroundColor: FitAiColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: const Color(0xFFF3F3FE),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: FitAiColors.royalBlue,
                  size: 36,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'FitAI',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: FitAiColors.royalBlue,
                  fontSize: 48,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'SEU TREINO COM IA',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF505F76),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: 2.4,
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
