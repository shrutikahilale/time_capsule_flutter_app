import 'package:time_capsule_app/modal/time_capsule_model.dart';

class User {
  String name;
  List<TimeCapsule> timeCapsules;

  User({
    required this.name,
    required this.timeCapsules,
  });
}
