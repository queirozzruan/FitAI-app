import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, this.onFinished});

  final VoidCallback? onFinished;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      children: [
                        const _OnboardingOrbit(),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'Seu treino, do seu jeito',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                height: 1.15,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Planos simples para treinar com foco, registrar sua evolucao e manter consistencia.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF434655),
                                height: 1.6,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const _InsightCard(),
                        const Spacer(),
                        _OnboardingButton(onPressed: onFinished),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingButton extends StatelessWidget {
  const _OnboardingButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF004AC6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: onPressed,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Comece ja'),
            SizedBox(width: AppSpacing.sm),
            Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E2ED)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            color: Color(0x0D000000),
            offset: Offset(0, 20),
            spreadRadius: -10,
          ),
        ],
        color: FitAiColors.white.withValues(alpha: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: const Color(0xFFDBE1FF),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: FitAiColors.royalBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treino personalizado',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'A ficha do MVP usa seus dados para mostrar o treino certo no momento certo.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: FitAiColors.textSecondary,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingOrbit extends StatelessWidget {
  const _OnboardingOrbit();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212,
      height: 232,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x80C3C6D7)),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            top: 16,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDBE1FF)),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            top: 32,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                border: Border.all(
                  color: FitAiColors.royalBlue.withValues(alpha: 0.2),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            top: 48,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    color: FitAiColors.royalBlue.withValues(alpha: 0.3),
                    offset: const Offset(0, 10),
                  ),
                ],
                color: const Color(0xFF004AC6),
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: FitAiColors.white,
                size: 36,
              ),
            ),
          ),
          const Positioned(
            left: 10,
            top: 136,
            child: _OrbitBadge(
              icon: Icons.monitor_heart_outlined,
              size: 40,
            ),
          ),
          const Positioned(
            right: 10,
            top: 0,
            child: _OrbitBadge(
              icon: Icons.insights_rounded,
              size: 32,
            ),
          ),
          const Positioned(
            right: 0,
            top: 96,
            child: _OrbitBadge(
              color: FitAiColors.royalBlue,
              icon: Icons.flash_on_rounded,
              iconColor: FitAiColors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbitBadge extends StatelessWidget {
  const _OrbitBadge({
    required this.icon,
    required this.size,
    this.color = FitAiColors.white,
    this.iconColor = FitAiColors.royalBlue,
  });

  final Color color;
  final IconData icon;
  final Color iconColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: size > 24 ? Border.all(color: const Color(0xFFE1E2ED)) : null,
        borderRadius: BorderRadius.circular(999),
        boxShadow: size > 24
            ? const [
                BoxShadow(
                  blurRadius: 2,
                  color: Color(0x0D000000),
                  offset: Offset(0, 1),
                ),
              ]
            : null,
        color: color,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.5),
    );
  }
}
