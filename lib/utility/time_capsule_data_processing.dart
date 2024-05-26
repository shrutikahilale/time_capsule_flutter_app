import 'package:flutter/material.dart';

Color getStateColor(String memoryState) {
  switch (memoryState) {
    case 'upcoming':
      return Colors.blueAccent;
    case 'active':
      return Colors.amber;
    default:
      return Colors.grey; // Fallback color
  }
}

String getReminderCriteriaImagePath(String reminderCriteria) {
  switch (reminderCriteria) {
    case 'Every week':
      return 'assets/icons/every_week_reminder.png';
    case 'Every day':
      return 'assets/icons/every_day_reminder.png';
    case 'Every month':
      return 'assets/icons/every_month_reminder.png';
    default:
      return 'assets/icons/every_year_reminder.png'; // Fallback color
  }
}
