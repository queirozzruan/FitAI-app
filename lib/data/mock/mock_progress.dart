import 'package:fitai/models/workout_log.dart';

const mockWeeklyFrequency = 4;
const mockCompletedWorkouts = 18;
const mockLoadProgressKg = 7.5;

final mockRecentWorkoutLogs = [
  WorkoutLog(
    exerciseId: 'bench-press',
    completedSets: 4,
    usedLoad: 62.5,
    performedReps: 9,
    notes: 'Boa estabilidade nas ultimas series.',
    date: DateTime(2026, 5, 19),
  ),
  WorkoutLog(
    exerciseId: 'lat-pulldown',
    completedSets: 4,
    usedLoad: 57.5,
    performedReps: 10,
    notes: 'Aumentar carga se a tecnica seguir consistente.',
    date: DateTime(2026, 5, 17),
  ),
  WorkoutLog(
    exerciseId: 'leg-press',
    completedSets: 4,
    usedLoad: 150,
    performedReps: 10,
    notes: 'Execucao controlada.',
    date: DateTime(2026, 5, 15),
  ),
];
