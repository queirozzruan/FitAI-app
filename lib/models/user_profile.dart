class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.goal,
    required this.availableDays,
    required this.injuries,
  });

  final int age;
  final List<String> availableDays;
  final String gender;
  final String goal;
  final double height;
  final String id;
  final List<String> injuries;
  final String name;
  final double weight;
}
