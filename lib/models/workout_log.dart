class WorkoutLog {
  const WorkoutLog({
    required this.exerciseId,
    required this.completedSets,
    required this.usedLoad,
    required this.performedReps,
    required this.notes,
    required this.date,
  });

  final int completedSets;
  final DateTime date;
  final String exerciseId;
  final String notes;
  final int performedReps;
  final double usedLoad;
}
