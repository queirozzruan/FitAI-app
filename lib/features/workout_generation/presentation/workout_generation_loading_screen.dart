import 'dart:async';

import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class WorkoutGenerationLoadingScreen extends StatefulWidget {
  const WorkoutGenerationLoadingScreen({super.key, this.onCompleted});

  final VoidCallback? onCompleted;

  @override
  State<WorkoutGenerationLoadingScreen> createState() =>
      _WorkoutGenerationLoadingScreenState();
}

class _WorkoutGenerationLoadingScreenState
    extends State<WorkoutGenerationLoadingScreen> {
  static const _loadingDuration = Duration(seconds: 7);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_loadingDuration, () {
      if (!mounted) {
        return;
      }

      widget.onCompleted?.call();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        const _GenerationTopBar(),
                        const Spacer(),
                        const _GenerationVisual(),
                        const SizedBox(height: AppSpacing.xxl),
                        Text(
                          'Estamos criando seu treino',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                height: 1.18,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'A IA do FitAI esta analisando seus dados, objetivos e limitacoes para montar uma ficha segura para voce.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF434655),
                                height: 1.6,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        const _GenerationProgress(),
                        const SizedBox(height: AppSpacing.xl),
                        const _GenerationChecklist(),
                        const Spacer(),
                        Text(
                          'Isso leva apenas alguns segundos.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFF737686),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
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

class _GenerationTopBar extends StatelessWidget {
  const _GenerationTopBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'FitAI',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: FitAiColors.royalBlue,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _GenerationVisual extends StatelessWidget {
  const _GenerationVisual();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 212,
      height: 212,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 212,
            height: 212,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x80C3C6D7)),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Container(
            width: 172,
            height: 172,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFDBE1FF)),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 7),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.rotate(
                angle: value * 6.28,
                child: child,
              );
            },
            child: Container(
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                border: Border.all(
                  color: FitAiColors.royalBlue.withValues(alpha: 0.22),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: _OrbitDot(),
                ),
              ),
            ),
          ),
          Container(
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
              Icons.auto_awesome_rounded,
              color: FitAiColors.white,
              size: 38,
            ),
          ),
          const Positioned(
            left: 18,
            bottom: 28,
            child: _FloatingSignal(icon: Icons.monitor_heart_outlined),
          ),
          const Positioned(
            right: 18,
            top: 22,
            child: _FloatingSignal(icon: Icons.fitness_center_rounded),
          ),
        ],
      ),
    );
  }
}

class _OrbitDot extends StatelessWidget {
  const _OrbitDot();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFF004AC6),
      ),
      child: const SizedBox(width: 14, height: 14),
    );
  }
}

class _FloatingSignal extends StatelessWidget {
  const _FloatingSignal({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E2ED)),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            color: Color(0x0D000000),
            offset: Offset(0, 1),
          ),
        ],
        color: FitAiColors.white,
      ),
      child: Icon(icon, color: FitAiColors.royalBlue, size: 20),
    );
  }
}

class _GenerationProgress extends StatelessWidget {
  const _GenerationProgress();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 7),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                backgroundColor: const Color(0xFFE1E2ED),
                color: const Color(0xFF004AC6),
                minHeight: 8,
                value: value,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentStep(value),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF505F76),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(value * 100).round()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: FitAiColors.royalBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _currentStep(double value) {
    if (value < 0.34) {
      return 'Lendo anamnese';
    }

    if (value < 0.68) {
      return 'Ajustando limitacoes';
    }

    return 'Montando ficha';
  }
}

class _GenerationChecklist extends StatelessWidget {
  const _GenerationChecklist();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: AppSpacing.sm,
      spacing: AppSpacing.sm,
      children: const [
        _GenerationChip(label: 'Dados fisicos'),
        _GenerationChip(label: 'Objetivo'),
        _GenerationChip(label: 'Limitacoes'),
      ],
    );
  }
}

class _GenerationChip extends StatelessWidget {
  const _GenerationChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x332563EB)),
        borderRadius: BorderRadius.circular(999),
        color: const Color(0x1A2563EB),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFF004AC6),
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF004AC6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
