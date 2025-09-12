import 'package:flutter/foundation.dart';

import '../db/database_helper.dart';
import '../models/activity.dart';

class ActivityProvider with ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  List<Activity> _activities = [];

  ActivityProvider() {
    loadAllActivities();
  }

  List<Activity> get activities => _activities;

  Future loadAllActivities() async {
    _activities = await _db.getAllActivities();
    notifyListeners();
  }

  Future addActivity(Activity a) async {
    await _db.insertActivity(a);
    await loadAllActivities();
  }

  Future updateActivity(Activity a) async {
    await _db.updateActivity(a);
    await loadAllActivities();
  }

  Future deleteActivity(int id) async {
    await _db.deleteActivity(id);
    await loadAllActivities();
  }

// Helper: total steps for a specific day
  int stepsOn(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final total = _activities.where((a) {
      final ad = DateTime(a.date.year, a.date.month, a.date.day);
      return ad == d;
    }).fold<int>(0, (prev, a) => prev + a.steps);
    return total;
  }

// Helper: total calories for a specific day
  int caloriesOn(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final total = _activities.where((a) {
      final ad = DateTime(a.date.year, a.date.month, a.date.day);
      return ad == d;
    }).fold<int>(0, (prev, a) => prev + a.calories);
    return total;
  }

// Returns last 7 days steps (ordered oldest -> newest)
  List<int> last7DaysSteps() {
    final today = DateTime.now();
    return List.generate(7, (i) {
      final day = DateTime(today.year, today.month, today.day)
          .subtract(Duration(days: 6 - i));
      return stepsOn(day);
    });
  }
}
