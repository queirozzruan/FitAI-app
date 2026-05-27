import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/data/mock/mock_workouts.dart';
import 'package:fitai/models/exercise.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final workout = mockWorkoutOfTheDay;

    return Scaffold(
      backgroundColor: _workoutBackground,
      body: SafeArea(
        child: Column(
          children: [
            _WorkoutHeader(onBack: onBack),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 38, 20, 120),
                child: Column(
                  children: [
                    Text(
                      'Treino Simples',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall
                          ?.copyWith(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Execute o treino de hoje seguindo a ordem sugerida e respeitando os intervalos.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF434655),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    for (
                      var index = 0;
                      index < workout.exercises.length;
                      index++
                    )
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: index == workout.exercises.length - 1
                              ? 0
                              : AppSpacing.md,
                        ),
                        child: _ExerciseItemCard(
                          exercise: workout.exercises[index],
                          index: index,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _WorkoutFooter(),
    );
  }
}

class _WorkoutHeader extends StatelessWidget {
  const _WorkoutHeader({required this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x80E2E8F0))),
        color: Color(0xCCF8FAFC),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'FitAI',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: FitAiColors.royalBlue,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(
              color: const Color(0xFF434655),
              icon: const Icon(Icons.arrow_back_rounded, size: 22),
              onPressed: onBack,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseItemCard extends StatelessWidget {
  const _ExerciseItemCard({required this.exercise, required this.index});

  final Exercise exercise;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: FitAiColors.white,
        border: Border.all(color: const Color(0xFFEDEDF9)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            color: Color(0x05000000),
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 190,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ExerciseNumber(number: index + 1),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          exercise.muscleGroup,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFF505F76)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _ExerciseStat(label: 'Séries', value: '${exercise.sets}'),
                  _ExerciseStat(label: 'Reps', value: exercise.reps),
                  _ExerciseStat(
                    label: 'Carga',
                    value: exercise.suggestedLoad == 0
                        ? 'Livre'
                        : '${exercise.suggestedLoad.toStringAsFixed(0)} kg',
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    color: FitAiColors.royalBlue,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${exercise.restSeconds}s de descanso',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF434655),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseNumber extends StatelessWidget {
  const _ExerciseNumber({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Color(0x1A2563EB),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: FitAiColors.royalBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ExerciseStat extends StatelessWidget {
  const _ExerciseStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF737686),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: FitAiColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutFooter extends StatelessWidget {
  const _WorkoutFooter();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x00FAF8FF),
            Color(0xF2FAF8FF),
            _workoutBackground,
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: SizedBox(
            height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF004AC6),
                elevation: 0,
                shape: const StadiumBorder(
                  side: BorderSide(color: Color(0x33FFFFFF)),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {},
              child: const Text('Iniciar treino'),
            ),
          ),
        ),
      ),
    );
  }
}

const _workoutBackground = Color(0xFFFAF8FF);
