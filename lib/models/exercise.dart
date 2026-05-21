class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.sets,
    required this.reps,
    required this.suggestedLoad,
    required this.restSeconds,
    required this.instructions,
  });

  final String id;
  final String instructions;
  final String muscleGroup;
  final String name;
  final String reps;
  final int restSeconds;
  final int sets;
  final double suggestedLoad;
}
