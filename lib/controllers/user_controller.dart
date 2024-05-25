import 'dart:io';

import 'package:get/get.dart';
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
        memoryState: 'completed',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
      TimeCapsule(
        title: 'School memory',
        description:
            'Memories of school days, friendships, teachers, exams, school events, and college experiences',
        date: '01/06/2023',
        memoryState: 'ongoing',
        reminderCriteria: 'Every year',
        memories: <File>[File('assets/images/img.jpeg')],
      ),
    ].obs;
  }

  // Method to add a new time capsule
  Future<void> addTimeCapsule(TimeCapsule capsule) async {
    timeCapsules.add(capsule);
  }
}
