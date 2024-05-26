import 'dart:io';

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
    timeCapsules = [
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every day',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/04/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every day',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/01/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every day',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every week',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every month',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'upcoming',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'active',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
    ].obs;
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
      if (capsule.memoryState == "upcoming") {
        upcomingCapsules.add(capsule);
      } else {
        activeCapsules.add(capsule);
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
  DateTime get parsedDate => DateFormat('dd/MM/yyyy').parse(date);

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
