# 💪 PulseUp Mobile App 🏃‍♂️

A comprehensive fitness tracking application built with Flutter that helps users monitor their daily activities, workouts, and health metrics. Your personal fitness journey companion in your pocket!

![PulseUp Banner](https://via.placeholder.com/800x200?text=PulseUp:+Track+Your+Fitness+Journey)

## ✨ Features

- 👣 **Activity Tracking**: Log and monitor daily steps, calories burned, and workout sessions
- 📊 **Dashboard Overview**: View today's fitness summary and weekly progress at a glance
- 🏋️‍♀️ **Workout Logging**: Record different types of workouts with duration and calories burned
- 📈 **Progress Visualization**: Track your fitness journey with intuitive charts and graphs
- 📝 **Notes and Insights**: Add personal notes to your workout sessions for future reference
- 📅 **Historical Data**: Access your complete fitness history to analyze trends and improvements

## Technology Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Data Persistence**: SQLite (sqflite)
- **Charts and Visualizations**: fl_chart
- **Date & Time Utilities**: intl

## Getting Started

### Prerequisites

- Flutter SDK (>= 2.19.0)
- Dart SDK (>= 2.19.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/RensithUdara/PulseUp-Mobile-App.git
   ```

2. Navigate to the project directory:
   ```bash
   cd fitness_tracker_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                # Application entry point
├── db/
│   └── database_helper.dart # SQLite database operations
├── models/
│   └── activity.dart        # Data model for fitness activities
├── providers/
│   └── activity_provider.dart # State management for activities
├── screens/
│   ├── dashboard_screen.dart # Main dashboard UI
│   └── add_log_screen.dart   # Screen to add new activities
└── widgets/
    ├── activity_list_item.dart # List item for activities
    └── summary_card.dart       # Summary card for dashboard
```

## Usage

1. **View Dashboard**: Open the app to see your daily and weekly fitness summary.
2. **Add New Activity**: Tap the "+" button to log a new activity or workout.
3. **Record Metrics**: Enter steps, workout type, duration, and calories.
4. **Add Notes**: Include additional notes for your workout session.
5. **View Progress**: Check the charts on the dashboard to see your progress over time.

## Roadmap

- **Social Features**: Share achievements with friends
- **Fitness Challenges**: Join community challenges
- **Nutrition Tracking**: Log and monitor daily food intake
- **Integration with Wearables**: Connect with fitness devices for automatic tracking
- **Custom Goals**: Set personalized fitness goals and track progress

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [sqflite](https://pub.dev/packages/sqflite)
- [fl_chart](https://pub.dev/packages/fl_chart)

## Contact

Project Link: [https://github.com/RensithUdara/PulseUp-Mobile-App](https://github.com/RensithUdara/PulseUp-Mobile-App)