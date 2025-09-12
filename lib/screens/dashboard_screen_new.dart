import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../providers/activity_provider.dart';
import '../widgets/activity_list_item.dart';
import 'add_log_screen.dart';
import '../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddLogScreen()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<ActivityProvider>(
          builder: (context, provider, child) {
            final today = DateTime.now();
            final stepsToday = provider.stepsOn(today);
            final caloriesToday = provider.caloriesOn(today);
            final weekly = provider.last7DaysSteps();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Steps',
                          value: stepsToday.toString(),
                          icon: Icons.directions_walk,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SummaryCard(
                          title: 'Calories',
                          value: caloriesToday.toString(),
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Last 7 Days',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: charts.BarChart(
                          _createWeeklyData(weekly),
                          animate: true,
                          domainAxis: charts.OrdinalAxisSpec(
                            renderSpec: charts.SmallTickRendererSpec(
                              labelStyle: charts.TextStyleSpec(
                                fontSize: 10,
                                color: charts.MaterialPalette.black,
                              ),
                            ),
                          ),
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            renderSpec: charts.GridlineRendererSpec(
                              labelStyle: charts.TextStyleSpec(
                                fontSize: 10,
                                color: charts.MaterialPalette.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Recent Logs',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ...provider.activities
                      .take(8)
                      .map((a) => ActivityListItem(activity: a))
                      .toList(),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<charts.Series<StepData, String>> _createWeeklyData(List<int> weeklySteps) {
    final today = DateTime.now();
    final data = List<StepData>.generate(
      weeklySteps.length,
      (i) {
        final day = DateTime(today.year, today.month, today.day)
            .subtract(Duration(days: 6 - i));
        final shortDay = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1];
        return StepData(shortDay, weeklySteps[i]);
      },
    );

    return [
      charts.Series<StepData, String>(
        id: 'Steps',
        data: data,
        domainFn: (StepData steps, _) => steps.day,
        measureFn: (StepData steps, _) => steps.steps,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
  }
}

class StepData {
  final String day;
  final int steps;

  StepData(this.day, this.steps);
}