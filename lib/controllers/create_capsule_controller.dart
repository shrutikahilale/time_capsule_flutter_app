import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../modal/time_capsule_model.dart';

class CreateCapsuleController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late String reminderCriteria = 'Every year';
  List<String> reminderCriteriaItems = [
    'Every year',
    'Every month',
    'Every week',
    'Every day'
  ];
  RxString selectedDate = "".obs;
  final List<File> selectedImages = <File>[].obs;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Customize the appearance of the date picker
            colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.orange, // Change primary color
              onPrimary: Colors.white, // Change text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // Change button text color
              ),
            ),
            dialogBackgroundColor: Colors.white, // Change dialog background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null &&
        getDateFormattedToString(picked) != selectedDate.value) {
      selectedDate.value = '${picked.day}/${picked.month}/${picked.year}';
      update();
    }
  }

  String getDateFormattedToString(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
      update();
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImages.add(File(pickedFile.path));
      update();
    }
  }

  void deleteImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  Future<TimeCapsule> createMemory(BuildContext context) async {
    // this shall be later converted to api calls/storage to db
    return TimeCapsule(
      title: titleController.text.trim(),
      date: selectedDate.value,
      memories: selectedImages,
      description: descriptionController.text.toString(),
      reminderCriteria: reminderCriteria,
      memoryState: 'upcoming',
    );
  }

  void resetFields() {
    titleController.clear();
    descriptionController.clear();
    selectedDate.value = "";
    selectedImages.clear();
    update();
  }

  void updateReminderCriteria(String newValue) {
    reminderCriteria = newValue;
    update();
  }
}
