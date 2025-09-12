class Activity {
  int? id;
  DateTime date;
  int steps;
  String? workoutType;
  int? duration; // minutes
  int calories;
  String? notes;

  Activity({
    this.id,
    required this.date,
    this.steps = 0,
    this.workoutType,
    this.duration,
    this.calories = 0,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'steps': steps,
      'workoutType': workoutType,
      'duration': duration,
      'calories': calories,
      'notes': notes,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as int?,
      date: DateTime.parse(map['date'] as String),
      steps: (map['steps'] as int?) ?? 0,
      workoutType: map['workoutType'] as String?,
      duration: map['duration'] as int?,
      calories: (map['calories'] as int?) ?? 0,
      notes: map['notes'] as String?,
    );
  }
}
