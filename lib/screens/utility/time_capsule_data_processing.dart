import 'package:flutter/material.dart';

Color getStateColor(bool isCapsuleActive) {
  return isCapsuleActive ? Colors.amber : Colors.blueAccent;
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

String formatDate(DateTime dateString) {
  final day = dateString.day;
  final month = _getMonthName(dateString.month);
  final year = dateString.year;

  return '$day $month, $year';
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
