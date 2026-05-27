import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/core/services/anamnesis_store.dart';
import 'package:fitai/data/mock/mock_progress.dart';
import 'package:fitai/data/mock/mock_user.dart';
import 'package:fitai/models/anamnesis_data.dart';
import 'package:fitai/models/workout_log.dart';
import 'package:flutter/material.dart';

class ProgressProfileScreen extends StatelessWidget {
  const ProgressProfileScreen({super.key, this.onWorkoutsTap});

  final VoidCallback? onWorkoutsTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _progressBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _ProgressHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
                child: Column(
                  children: [
                    const _ProfileHero(),
                    const SizedBox(height: AppSpacing.xl),
                    const _PersistedAnamnesisCard(),
                    const SizedBox(height: AppSpacing.xl),
                    const _MetricGrid(),
                    const SizedBox(height: AppSpacing.xl),
                    const _ProgressChartCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _ProgressBottomBar(onWorkoutsTap: onWorkoutsTap),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader();

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

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return _ProgressCard(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 72,
            width: 72,
            decoration: const BoxDecoration(
              color: Color(0x1A2563EB),
              shape: BoxShape.circle,
            ),
            child: Text(
              _initialFrom(mockUser.name),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: FitAiColors.royalBlue,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            mockUser.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            mockUser.goal,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF505F76),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PersistedAnamnesisCard extends StatelessWidget {
  const _PersistedAnamnesisCard();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnamnesisData?>(
      future: AnamnesisStore.load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _ProgressCard(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data;

        if (data == null) {
          return _ProgressCard(
            child: Text(
              'Preencha a anamnese para visualizar seus dados salvos aqui.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF505F76),
                height: 1.5,
              ),
            ),
          );
        }

        return _ProgressCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.assignment_ind_outlined,
                    color: FitAiColors.royalBlue,
                    size: 22,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Dados da anamnese',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                runSpacing: AppSpacing.sm,
                spacing: AppSpacing.sm,
                children: [
                  _AnamnesisChip(label: 'Idade', value: '${data.age} anos'),
                  _AnamnesisChip(
                    label: 'Peso',
                    value: '${data.weight.toStringAsFixed(1)} kg',
                  ),
                  _AnamnesisChip(
                    label: 'Altura',
                    value: '${data.height.toStringAsFixed(0)} cm',
                  ),
                  _AnamnesisChip(label: 'Gênero', value: data.gender),
                  _AnamnesisChip(label: 'Objetivo', value: data.goal),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Limitações',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF505F76),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                data.limitations.trim().isEmpty
                    ? 'Nenhuma limitação informada.'
                    : data.limitations,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: FitAiColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnamnesisChip extends StatelessWidget {
  const _AnamnesisChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x332563EB)),
        borderRadius: BorderRadius.circular(999),
        color: const Color(0x1A2563EB),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF004AC6),
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid();

  @override
  Widget build(BuildContext context) {
    final recentSets = mockRecentWorkoutLogs.fold<int>(
      0,
      (total, log) => total + log.completedSets,
    );
    final recentVolume = mockRecentWorkoutLogs.fold<double>(
      0,
      (total, log) => total + _volumeFor(log),
    );

    final metrics = [
      _ProgressMetric(
        icon: Icons.event_repeat_rounded,
        label: 'Frequência semanal',
        value: '${mockWeeklyFrequency}x',
      ),
      _ProgressMetric(
        icon: Icons.check_circle_outline_rounded,
        label: 'Treinos concluídos',
        value: '$mockCompletedWorkouts',
      ),
      _ProgressMetric(
        icon: Icons.format_list_numbered_rounded,
        label: 'Séries recentes',
        value: '$recentSets',
      ),
      _ProgressMetric(
        icon: Icons.scale_outlined,
        label: 'Volume recente',
        value: _formatVolume(recentVolume),
      ),
    ];

    return GridView.builder(
      itemCount: metrics.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 173 / 145,
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemBuilder: (context, index) => metrics[index],
    );
  }
}

class _ProgressMetric extends StatelessWidget {
  const _ProgressMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _ProgressCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: FitAiColors.royalBlue, size: 22),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF505F76),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressChartCard extends StatelessWidget {
  const _ProgressChartCard();

  @override
  Widget build(BuildContext context) {
    final volumes = [
      for (final log in mockRecentWorkoutLogs) _volumeFor(log),
    ];
    final maxVolume = volumes.fold<double>(
      0,
      (currentMax, volume) => volume > currentMax ? volume : currentMax,
    );

    return _ProgressCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Volume por treino',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Séries x repetições x carga dos últimos registros.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF505F76),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 192,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (
                  var index = 0;
                  index < mockRecentWorkoutLogs.length;
                  index++
                )
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: _ProgressBar(
                        heightFactor: maxVolume == 0
                            ? 0.2
                            : (volumes[index] / maxVolume)
                                  .clamp(0.2, 1.0)
                                  .toDouble(),
                        label: _shortExerciseLabel(
                          mockRecentWorkoutLogs[index].exerciseId,
                        ),
                        valueLabel: _formatCompactVolume(volumes[index]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mockRecentWorkoutLogs
                .map(
                  (log) => Text(
                    '${log.date.day}/${log.date.month}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF737686),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.heightFactor,
    required this.label,
    required this.valueLabel,
  });

  final double heightFactor;
  final String label;
  final String valueLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valueLabel,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: FitAiColors.royalBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: heightFactor,
              child: Container(
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [FitAiColors.royalBlue, Color(0x332563EB)],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 18,
          child: Text(
            _shortExerciseLabel(label),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF505F76),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBottomBar extends StatelessWidget {
  const _ProgressBottomBar({required this.onWorkoutsTap});

  final VoidCallback? onWorkoutsTap;

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
              _BottomBarItem(
                icon: Icons.fitness_center_rounded,
                label: 'TREINOS',
                onTap: onWorkoutsTap,
              ),
              const _BottomBarItem(
                icon: Icons.trending_up_rounded,
                isActive: true,
                label: 'EVOLUÇÃO',
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
            Icon(icon, color: color, size: isActive ? 25 : 21),
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

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: FitAiColors.white,
        border: Border.all(color: const Color(0xFFEDEDF9)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            color: Color(0x08000000),
            offset: Offset(0, 10),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

String _shortExerciseLabel(String exerciseId) {
  if (exerciseId == 'bench-press') {
    return 'Supino';
  }

  if (exerciseId == 'lat-pulldown') {
    return 'Puxada';
  }

  if (exerciseId == 'leg-press') {
    return 'Leg';
  }

  return 'Carga';
}

double _volumeFor(WorkoutLog log) {
  return log.usedLoad * log.completedSets * log.performedReps;
}

String _formatCompactVolume(double kg) {
  if (kg >= 1000) {
    return '${(kg / 1000).toStringAsFixed(1).replaceAll('.', ',')}t';
  }

  return '${kg.toStringAsFixed(0)}kg';
}

String _formatVolume(double kg) {
  if (kg >= 1000) {
    return '${(kg / 1000).toStringAsFixed(1).replaceAll('.', ',')} t';
  }

  return '${kg.toStringAsFixed(0)} kg';
}

String _initialFrom(String name) {
  if (name.isEmpty) {
    return '?';
  }

  return name.substring(0, 1).toUpperCase();
}

const _progressBackground = Color(0xFFFAF8FF);
