import 'dart:io';

class TimeCapsule {
  String title;
  String? description;
  String date;
  String memoryState;
  String reminderCriteria;
  List<File> memories;

  TimeCapsule({
    required this.title,
    this.description,
    required this.date,
    required this.memories,
    required this.reminderCriteria,
    required this.memoryState,
  });
}
