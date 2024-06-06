import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_capsule_app/modal/time_capsule_model_v2.dart';
import 'package:time_capsule_app/services/auth_service.dart';

import '../services/database_service.dart';

class UserController extends GetxController {
  var timeCapsules = <TimeCapsule>[].obs;
  String userId = '';

  final DatabaseService _databaseService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    userId = _authService.currentUserId!;
    super.onInit();
  }

  Future<List<TimeCapsule>> fetchTimeCapsuleData(String userId) async {
    return await _databaseService.fetchTimeCapsules(userId);
  }

  Future<List<TimeCapsule>> getData() async {
    timeCapsules.value = await fetchTimeCapsuleData(userId);
    if (kDebugMode) {
      print('TIME CAPSULES: $timeCapsules');
    }
    return timeCapsules;
  }

  // Method to add a new time capsule
  Future<bool> addTimeCapsule(String title, String description, String date,
      String reminderCriteria, List<File> images) async {
    final response = await _databaseService.createTimeCapsule(
        userId, title, description, date, reminderCriteria, images);
    if (response == 'success') return true;
    return false;
  }

  List<TimeCapsule> get sortedTimeCapsules {
    List<TimeCapsule> upcomingCapsules = [];
    List<TimeCapsule> activeCapsules = [];
    DateTime now = DateTime.now();

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
