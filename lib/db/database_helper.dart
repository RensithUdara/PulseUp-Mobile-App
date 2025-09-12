import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/activity.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('fitness_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final path = join(docsDir.path, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE activities(
id INTEGER PRIMARY KEY AUTOINCREMENT,
date TEXT NOT NULL,
steps INTEGER NOT NULL,
workoutType TEXT,
duration INTEGER,
calories INTEGER,
notes TEXT
)
''');
  }

  Future<Activity> insertActivity(Activity activity) async {
    final db = await database;
    final id = await db.insert('activities', activity.toMap());
    activity.id = id;
    return activity;
  }

  Future<List<Activity>> getAllActivities() async {
    final db = await database;
    final result = await db.query('activities', orderBy: 'date DESC');
    return result.map((m) => Activity.fromMap(m)).toList();
  }

  Future<List<Activity>> getActivitiesBetween(
      DateTime start, DateTime end) async {
    final db = await database;
    final res = await db.query(
      'activities',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'date ASC',
    );
    return res.map((m) => Activity.fromMap(m)).toList();
  }

  Future<int> updateActivity(Activity activity) async {
    final db = await database;
    return await db.update('activities', activity.toMap(),
        where: 'id = ?', whereArgs: [activity.id]);
  }

  Future<int> deleteActivity(int id) async {
    final db = await database;
    return await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
