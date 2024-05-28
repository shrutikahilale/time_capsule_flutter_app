class User {
  int id;
  String name;
  String email;
  DateTime createdAt;
  List<int> timeCapsules;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.timeCapsules,
  });
}
