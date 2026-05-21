import 'package:fitai/models/exercise.dart';

class Workout {
  const Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.dayLabel,
    required this.exercises,
  });

  final String dayLabel;
  final String description;
  final List<Exercise> exercises;
  final String id;
  final String name;
}
