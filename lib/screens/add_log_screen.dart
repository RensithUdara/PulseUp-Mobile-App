import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/activity_provider.dart';

class AddLogScreen extends StatefulWidget {
  final Activity? activity;

  const AddLogScreen({Key? key, this.activity}) : super(key: key);

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  int _steps = 0;
  String? _workoutType;
  int? _duration;
  int _calories = 0;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _date = widget.activity?.date ?? DateTime.now();
    _steps = widget.activity?.steps ?? 0;
    _workoutType = widget.activity?.workoutType;
    _duration = widget.activity?.duration;
    _calories = widget.activity?.calories ?? 0;
    _notes = widget.activity?.notes;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final activity = Activity(
        id: widget.activity?.id,
        date: _date,
        steps: _steps,
        workoutType: _workoutType,
        duration: _duration,
        calories: _calories,
        notes: _notes,
      );

      final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
      
      if (widget.activity == null) {
        activityProvider.addActivity(activity);
      } else {
        activityProvider.updateActivity(activity);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity == null ? 'Add Activity' : 'Edit Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Date Picker
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _date) {
                    setState(() {
                      _date = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat.yMMMd().format(_date)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Steps
              TextFormField(
                initialValue: _steps.toString(),
                decoration: const InputDecoration(
                  labelText: 'Steps',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of steps';
                  }
                  return null;
                },
                onSaved: (value) {
                  _steps = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),

              // Workout Type
              TextFormField(
                initialValue: _workoutType,
                decoration: const InputDecoration(
                  labelText: 'Workout Type (optional)',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _workoutType = value;
                },
              ),
              const SizedBox(height: 16),

              // Duration
              TextFormField(
                initialValue: _duration?.toString() ?? '',
                decoration: const InputDecoration(
                  labelText: 'Duration in minutes (optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _duration = int.parse(value);
                  } else {
                    _duration = null;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Calories
              TextFormField(
                initialValue: _calories.toString(),
                decoration: const InputDecoration(
                  labelText: 'Calories',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter calories burned';
                  }
                  return null;
                },
                onSaved: (value) {
                  _calories = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                initialValue: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) {
                  _notes = value;
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _save,
                child: Text(widget.activity == null ? 'Add Activity' : 'Update Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
