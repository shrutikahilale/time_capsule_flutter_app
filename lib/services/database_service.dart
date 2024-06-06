import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:time_capsule_app/main.dart';
import 'package:time_capsule_app/modal/time_capsule_model_v2.dart';

class DatabaseService {
  // add user details to 'users' table
  Future<void> createUser(
      String email, String uid, String name, DateTime dob) async {
    final response = await supabase.from('users').insert({
      'email': email,
      'name': name,
      'id': uid,
      'timeCapsules': [],
      'createdAt': DateTime.now().toIso8601String(),
    });

    if (response.error != null) {
      // show snack bar of error
    }
  }

  Future<List<String>> uploadImagesToClientStorage(
      String userId, List<File> images) async {
    List<String> urls = [];

    final bucket = supabase.storage.from('images/$userId');

    for (var img in images) {
      final fileName = img.path.split('/').last;
      final fileBytes = await img.readAsBytes();
      try {
        await bucket.uploadBinary(fileName, fileBytes);
      } catch (e) {
        if (e is StorageException && e.statusCode == '409') {
          if (kDebugMode) {
            print('Resource already exists');
          }
        }
      }
      final imageUrl = bucket.getPublicUrl(fileName);
      if (kDebugMode) {
        print(
            '*********************************************** Uploading new one $imageUrl');
      }
      urls.add(imageUrl);
    }
    return urls;
  }

  /* GET ALL TIME CAPSULES
     1. using current userID, get all time capsules IDs from "users" table
     2. using each time capsules ID, get data from "time_capsules" table
     3. using memory IDs, get memories urls mapped with each time capsule
   */
  Future<List<TimeCapsule>> fetchTimeCapsules(String userId) async {
    List<TimeCapsule> result = [];
    List<String> timeCapsuleIds = await getAllTimeCapsulesIds(userId);
    if (timeCapsuleIds.isEmpty) return result;

    result = await getAllTimeCapsulesData(timeCapsuleIds);
    if (kDebugMode) {
      print('result $result');
    }
    return result;
  }

  Future<List<String>> getAllTimeCapsulesIds(String userId) async {
    final response = await supabase
        .from('users')
        .select('timeCapsules')
        .eq('id', userId)
        .single();
    List<dynamic> timeCapsulesIds = response['timeCapsules'];
    if (kDebugMode) {
      print('timeCapsulesIds $timeCapsulesIds');
    }
    return timeCapsulesIds.map((e) => e.toString()).toList();
  }

  Future<List<TimeCapsule>> getAllTimeCapsulesData(
      List<String> timeCapsulesIDs) async {
    final response = await supabase
        .from('timeCapsules')
        .select()
        .inFilter('id', timeCapsulesIDs);

    List<TimeCapsule> list = [];

    for (var data in response) {
      list.add(getTimeCapsuleFormatted(data));
    }
    if (kDebugMode) {
      print('list $list');
    }

    return list;
  }

  TimeCapsule getTimeCapsuleFormatted(
      Map<String, dynamic> timeCapsuleDataResponse) {
    List<dynamic> urls = timeCapsuleDataResponse['memoryUrls'];
    return TimeCapsule(
      id: timeCapsuleDataResponse['id'],
      title: timeCapsuleDataResponse['title'],
      description: timeCapsuleDataResponse['description'],
      date: DateTime.parse(timeCapsuleDataResponse['date']
          .toString()
          .substring(0, 10)
          .replaceAll('-', '-')),
      memories: urls.map((e) => e.toString()).toList(),
      reminderCriteria: timeCapsuleDataResponse['reminderCriteria'],
    );
  }

  Future<int> getTimeCapsuleLength(String userId) async {
    final response =
        await supabase.from('users').select('timeCapsules').eq('id', userId);
    return response.length;
  }

  Future<String> createTimeCapsule(
    String userId,
    String title,
    String description,
    String date,
    String reminderCriteria,
    List<File> images,
  ) async {
    try {
      // create memory Urls
      List<String> urls = await uploadImagesToClientStorage(userId, images);

      // add image urls to memories db
      if (urls.isNotEmpty) {
        // retrieve all time capsules of current user
        List<String> timeCapsules = await getAllTimeCapsulesIds(userId);
        String timeCapsuleId = '${userId}_id_${timeCapsules.length + 1}';
        // add to it first
        timeCapsules.add(timeCapsuleId);
        // update to user's db
        await supabase
            .from('users')
            .update({'timeCapsules': timeCapsules}).eq('id', userId);

        final dateFormat = DateFormat('dd-MM-yyyy');
        final dateParsed = dateFormat.parse(date.split('/').reversed.join('-'));

        final dateTimeString = dateParsed.toIso8601String();
        // add to timeCapsules db
        await supabase.from('timeCapsules').insert({
          'id': timeCapsuleId,
          'title': title,
          'description': description,
          'date': dateTimeString,
          'reminderCriteria': reminderCriteria,
          'memoryUrls': urls
        });
        return 'success';
      } else {
        return 'upload failed';
      }
    } catch (e) {
      if (kDebugMode) {
        print('inside catch block of createTimeCapsule(): $e');
      }
      return 'false';
    }
  }
}
