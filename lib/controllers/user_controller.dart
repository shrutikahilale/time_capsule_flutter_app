import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_capsule_app/modal/time_capsule_model.dart';

class UserController extends GetxController {
  var timeCapsules = <TimeCapsule>[].obs;

  @override
  void onInit() {
    initializeUser();
    super.onInit();
  }

  initializeUser() {
    // timeCapsules = [

    // ].obs;
  }

  // Method to add a new time capsule
  Future<void> addTimeCapsule(TimeCapsule capsule) async {
    timeCapsules.add(capsule);
  }

  List<TimeCapsule> get sortedTimeCapsules {
    List<TimeCapsule> upcomingCapsules = [];
    List<TimeCapsule> activeCapsules = [];
    DateTime now = DateTime.now();

    // Separate the capsules
    for (var capsule in timeCapsules) {
      if (capsule.isCapsuleActive) {
        activeCapsules.add(capsule);
      } else {
        upcomingCapsules.add(capsule);
      }
    }

    // Sort each list based on nextReminderDate
    upcomingCapsules.sort(
        (a, b) => a.nextReminderDate(now).compareTo(b.nextReminderDate(now)));
    activeCapsules.sort(
        (a, b) => a.nextReminderDate(now).compareTo(b.nextReminderDate(now)));

    // Concatenate the lists with upcomingCapsules first
    List<TimeCapsule> sortedCapsules = [...activeCapsules, ...upcomingCapsules];

    return sortedCapsules;
  }

  // Function to parse date
  DateTime parseDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }
}

extension on TimeCapsule {
  DateTime get parsedDate => date;

  DateTime nextReminderDate(DateTime currentDate) {
    switch (reminderCriteria) {
      case 'Every day':
        return parsedDate.isBefore(currentDate) ? currentDate : parsedDate;
      case 'Every week':
        return parsedDate.isBefore(currentDate)
            ? currentDate.add(
                Duration(days: 7 - currentDate.weekday + parsedDate.weekday))
            : parsedDate;
      case 'Every month':
        return parsedDate.isBefore(currentDate)
            ? DateTime(currentDate.year, currentDate.month + 1, parsedDate.day)
            : parsedDate;
      case 'Every year':
        return parsedDate.isBefore(currentDate)
            ? DateTime(currentDate.year + 1, parsedDate.month, parsedDate.day)
            : parsedDate;
      default:
        return parsedDate;
    }
  }
}
