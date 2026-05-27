class AnamnesisData {
  const AnamnesisData({
    required this.age,
    required this.createdAt,
    required this.gender,
    required this.goal,
    required this.height,
    required this.limitations,
    required this.weight,
  });

  factory AnamnesisData.fromJson(Map<String, dynamic> json) {
    return AnamnesisData(
      age: json['age'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      gender: json['gender'] as String,
      goal: json['goal'] as String,
      height: (json['height'] as num).toDouble(),
      limitations: json['limitations'] as String,
      weight: (json['weight'] as num).toDouble(),
    );
  }

  final int age;
  final DateTime createdAt;
  final String gender;
  final String goal;
  final double height;
  final String limitations;
  final double weight;

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'createdAt': createdAt.toIso8601String(),
      'gender': gender,
      'goal': goal,
      'height': height,
      'limitations': limitations,
      'weight': weight,
    };
  }
}
