class TimeCapsule {
  String id;
  String title;
  String? description;
  DateTime date;
  String reminderCriteria;
  List<String> memories;

  TimeCapsule({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.reminderCriteria,
    required this.memories,
  });
}
