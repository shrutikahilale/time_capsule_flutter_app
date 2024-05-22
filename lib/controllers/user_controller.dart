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
          title: 'First childhood photograph',
          description:
              'Recollections of carefree days, playing with friends, family vacations, and special moments with siblings',
          date: '24/12/2003',
          memoryState: 'upcoming',
          reminderCriteria: 'Every year',
          memories: <File>[File('assets/images/img.jpeg')]),
      TimeCapsule(
          title: 'School memory',
          description:
              'Memories of school days, friendships, teachers, exams, school events, and college experiences',
          date: '13/08/2015',
          memoryState: 'upcoming',
          reminderCriteria: 'Every month',
          memories: <File>[File('assets/images/img.jpeg')]),
    ].obs;
  }

  // Method to add a new time capsule
  Future<void> addTimeCapsule(TimeCapsule capsule) async {
    timeCapsules.add(capsule);
  }
}
