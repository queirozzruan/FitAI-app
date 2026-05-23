import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/data/mock/mock_workouts.dart';
import 'package:fitai/models/exercise.dart';
import 'package:fitai/models/workout_log.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _completedSets = <String, int>{};
  final _lastLoads = <String, double>{};
  final _lastReps = <String, int>{};
  final _logs = <WorkoutLog>[];

  void _openExerciseLog(Exercise exercise) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _ExerciseLogSheet(
          completedSets: _completedSets[exercise.id] ?? 0,
          exercise: exercise,
          onSave: ({required load, required notes, required reps}) {
            setState(() {
              final completedSets = _completedSets[exercise.id] ?? 0;
              final nextCompletedSets = completedSets >= exercise.sets
                  ? exercise.sets
                  : completedSets + 1;

              _completedSets[exercise.id] = nextCompletedSets;
              _lastLoads[exercise.id] = load;
              _lastReps[exercise.id] = reps;
              _logs.add(
                WorkoutLog(
                  completedSets: nextCompletedSets,
                  date: DateTime.now(),
                  exerciseId: exercise.id,
                  notes: notes,
                  performedReps: reps,
                  usedLoad: load,
                ),
              );
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final workout = mockWorkoutOfTheDay;

    return Scaffold(
      backgroundColor: _workoutBackground,
      body: SafeArea(
        child: Column(
          children: [
            _WorkoutHeader(onBack: widget.onBack),
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
                          completedSets:
                              _completedSets[workout.exercises[index].id] ?? 0,
                          exercise: workout.exercises[index],
                          index: index,
                          lastLoad:
                              _lastLoads[workout.exercises[index].id],
                          lastReps: _lastReps[workout.exercises[index].id],
                          onRegister: () {
                            _openExerciseLog(workout.exercises[index]);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _WorkoutFooter(registeredSets: _logs.length),
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
  const _ExerciseItemCard({
    required this.completedSets,
    required this.exercise,
    required this.index,
    required this.onRegister,
    this.lastLoad,
    this.lastReps,
  });

  final int completedSets;
  final Exercise exercise;
  final int index;
  final double? lastLoad;
  final int? lastReps;
  final VoidCallback onRegister;

  String get _loadLabel {
    if (lastLoad != null) {
      return '${lastLoad!.toStringAsFixed(0)} kg';
    }

    if (exercise.suggestedLoad == 0) {
      return 'Livre';
    }

    return '${exercise.suggestedLoad.toStringAsFixed(0)} kg';
  }

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
                  _ExerciseStat(
                    label: 'Series',
                    value: '$completedSets/${exercise.sets}',
                  ),
                  _ExerciseStat(
                    label: 'Reps',
                    value: lastReps?.toString() ?? exercise.reps,
                  ),
                  _ExerciseStat(
                    label: 'Carga',
                    value: _loadLabel,
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
                  const Spacer(),
                  SizedBox(
                    height: 32,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: FitAiColors.royalBlue,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        side: const BorderSide(color: Color(0x332563EB)),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: onRegister,
                      child: const Text('Registrar serie'),
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
  const _WorkoutFooter({required this.registeredSets});

  final int registeredSets;

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
              child: Text(
                registeredSets == 0 ? 'Iniciar treino' : 'Finalizar treino',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseLogSheet extends StatefulWidget {
  const _ExerciseLogSheet({
    required this.completedSets,
    required this.exercise,
    required this.onSave,
  });

  final int completedSets;
  final Exercise exercise;
  final void Function({
    required double load,
    required String notes,
    required int reps,
  }) onSave;

  @override
  State<_ExerciseLogSheet> createState() => _ExerciseLogSheetState();
}

class _ExerciseLogSheetState extends State<_ExerciseLogSheet> {
  late final TextEditingController _loadController;
  late final TextEditingController _notesController;
  late final TextEditingController _repsController;

  @override
  void initState() {
    super.initState();

    _loadController = TextEditingController(
      text: widget.exercise.suggestedLoad == 0
          ? ''
          : widget.exercise.suggestedLoad.toStringAsFixed(0),
    );
    _notesController = TextEditingController();
    _repsController = TextEditingController(
      text: _firstNumberFrom(widget.exercise.reps),
    );
  }

  @override
  void dispose() {
    _loadController.dispose();
    _notesController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _save() {
    final load = double.tryParse(_loadController.text.replaceAll(',', '.')) ?? 0;
    final reps = int.tryParse(_repsController.text) ?? 0;

    widget.onSave(
      load: load,
      notes: _notesController.text.trim(),
      reps: reps,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: FitAiColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registrar serie',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.exercise.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF505F76),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _loadController,
                        decoration: const InputDecoration(
                          labelText: 'Carga utilizada',
                          suffixText: 'kg',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: TextField(
                        controller: _repsController,
                        decoration: const InputDecoration(
                          labelText: 'Repeticoes',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    hintText: 'Observacoes simples',
                    labelText: 'Observacoes',
                  ),
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF004AC6),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: _save,
                    child: Text(
                      widget.completedSets + 1 >= widget.exercise.sets
                          ? 'Salvar ultima serie'
                          : 'Salvar serie',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _firstNumberFrom(String value) {
  return RegExp(r'\d+').firstMatch(value)?.group(0) ?? '';
}

const _workoutBackground = Color(0xFFFAF8FF);
