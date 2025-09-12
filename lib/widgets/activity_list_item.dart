import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../providers/activity_provider.dart';
import '../screens/add_log_screen.dart';

class ActivityListItem extends StatelessWidget {
  final Activity activity;

  const ActivityListItem({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd().format(activity.date),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddLogScreen(activity: activity),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Delete Activity'),
                            content: const Text('Are you sure you want to delete this activity?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<ActivityProvider>(context, listen: false)
                                      .deleteActivity(activity.id!);
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_walk, size: 18),
                        const SizedBox(width: 4),
                        Text('${activity.steps} steps'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department, size: 18),
                        const SizedBox(width: 4),
                        Text('${activity.calories} calories'),
                      ],
                    ),
                  ],
                ),
                if (activity.workoutType != null && activity.duration != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(activity.workoutType!),
                      Text('${activity.duration} mins'),
                    ],
                  ),
              ],
            ),
            if (activity.notes != null && activity.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Divider(),
              Text(activity.notes!),
            ],
          ],
        ),
      ),
    );
  }
}
