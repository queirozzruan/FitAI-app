import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
              const Spacer(),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: FitAiColors.white,
                  strokeWidth: 2.4,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
