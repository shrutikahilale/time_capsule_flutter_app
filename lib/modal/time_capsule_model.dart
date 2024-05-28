import 'dart:io';

class TimeCapsule {
  int id;
  String title;
  String? description;
  DateTime date;
  bool isCapsuleActive;
  String reminderCriteria;
  List<File> memories;

  TimeCapsule({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.isCapsuleActive,
    required this.reminderCriteria,
    required this.memories,
  });
}
