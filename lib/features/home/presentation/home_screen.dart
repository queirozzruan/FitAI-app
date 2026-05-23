import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/data/mock/mock_workouts.dart';
import 'package:fitai/models/workout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onProgressTap, this.onWorkoutSelected});

  final VoidCallback? onProgressTap;
  final ValueChanged<Workout>? onWorkoutSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _homeBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 38, 20, 36),
                child: Column(
                  children: [
                    Text(
                      'Agenda de Treino',
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
                      'Selecione seu treino de hoje.\nLembre-se, consistencia e a chave para um bom resultado.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF434655),
                        fontSize: 18,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 45),
                    for (var index = 0; index < mockWorkouts.length; index++)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: index == mockWorkouts.length - 1 ? 0 : 23,
                        ),
                        child: _WorkoutDayCard(
                          dayIndex: index,
                          isActive: index == 0,
                          onPressed: onWorkoutSelected == null
                              ? null
                              : () => onWorkoutSelected!(mockWorkouts[index]),
                          workout: mockWorkouts[index],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _HomeBottomBar(onProgressTap: onProgressTap),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x80E2E8F0))),
        color: Color(0xCCF8FAFC),
      ),
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      width: double.infinity,
      child: Text(
        'FitAI',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: FitAiColors.royalBlue,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _WorkoutDayCard extends StatelessWidget {
  const _WorkoutDayCard({
    required this.dayIndex,
    required this.isActive,
    required this.onPressed,
    required this.workout,
  });

  final int dayIndex;
  final bool isActive;
  final VoidCallback? onPressed;
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FitAiColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          height: isActive ? 205 : 179,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive
                  ? const Color(0x332563EB)
                  : const Color(0x80E1E2ED),
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: isActive ? 40 : 30,
                color: isActive
                    ? const Color(0x08000000)
                    : const Color(0x05000000),
                offset: const Offset(0, 10),
              ),
            ],
            gradient: isActive
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0x0D2563EB), Color(0x00FFFFFF)],
                  )
                : null,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _DayBadge(dayIndex: dayIndex, isActive: isActive),
                            const Spacer(),
                            if (isActive) const _TodayBadge(),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          workout.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.description,
                          maxLines: isActive ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: const Color(0xFF505F76)),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            const Icon(
                              Icons.fitness_center_rounded,
                              color: FitAiColors.royalBlue,
                              size: 16,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${workout.exercises.length} exercicios',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF434655),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isActive)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ColoredBox(
                    color: FitAiColors.royalBlue,
                    child: SizedBox(height: 4),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayBadge extends StatelessWidget {
  const _DayBadge({required this.dayIndex, required this.isActive});

  final int dayIndex;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isActive ? const Color(0x1A2563EB) : const Color(0xFFF8FAFC),
      ),
      child: Text(
        'Dia ${dayIndex + 1}',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isActive ? FitAiColors.royalBlue : const Color(0xFF505F76),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TodayBadge extends StatelessWidget {
  const _TodayBadge();

  @override
  Widget build(BuildContext context) {
    return Text(
      'HOJE',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: FitAiColors.royalBlue,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _HomeBottomBar extends StatelessWidget {
  const _HomeBottomBar({required this.onProgressTap});

  final VoidCallback? onProgressTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Color(0x0D000000),
            offset: Offset(0, -10),
          ),
        ],
        color: Color(0xE6FFFFFF),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const _BottomBarItem(
                icon: Icons.fitness_center_rounded,
                isActive: true,
                label: 'TREINOS',
              ),
              _BottomBarItem(
                icon: Icons.trending_up_rounded,
                label: 'EVOLUCAO',
                onTap: onProgressTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? FitAiColors.royalBlue : const Color(0xFF505F76);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 88,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: isActive ? 21 : 25),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _homeBackground = Color(0xFFFAF8FF);
