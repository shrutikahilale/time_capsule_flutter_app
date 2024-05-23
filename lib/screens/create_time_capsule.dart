import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_capsule_controller.dart';
import '../controllers/user_controller.dart';

// ignore: must_be_immutable
class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final CreateCapsuleController controller = Get.put(CreateCapsuleController());
  final userController = Get.find<UserController>();

  var dropdownValue = 'Every year';

  @override
  Widget build(BuildContext context) {
    // Call resetFields when the screen is initialized
    controller.resetFields();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Memory',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              const Text('Enter title'),
              TextFormField(
                controller: controller.titleController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Enter description'),
              TextFormField(
                controller: controller.descriptionController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Select date'),
              ListTile(
                trailing: IconButton(
                  onPressed: () async {
                    await controller.selectDate(context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                title: Obx(
                  () => Text(
                    controller.selectedDate.value.isEmpty
                        ? 'No date selected'
                        : controller.selectedDate.value,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('How often do you want to be reminded?'),
              const SizedBox(height: 16.0),
              GetBuilder<CreateCapsuleController>(
                builder: (controller) => DropdownButton(
                  value: controller.reminderCriteria,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.reminderCriteriaItems.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    controller.updateReminderCriteria(newValue!);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Select your memories'),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.getImageFromGallery,
                    icon: const Icon(
                      Icons.photo,
                      size: 32.0,
                    ),
                  ),
                  const Text('Or'),
                  IconButton(
                    onPressed: controller.getImageFromCamera,
                    icon: const Icon(
                      Icons.camera,
                      size: 32.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => Wrap(
                  children: controller.selectedImages.isEmpty
                      ? [const Text('No photo is selected')]
                      : [
                          Wrap(
                            children: controller.selectedImages
                                .asMap()
                                .map((index, file) => MapEntry(
                                    index,
                                    Stack(children: [
                                      Image.file(
                                        file,
                                        width: 100,
                                        height: 100,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () =>
                                              controller.deleteImage(index),
                                          icon: const Icon(Icons.close),
                                        ),
                                      ),
                                    ])))
                                .values
                                .toList(),
                          )
                        ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextButton(
                onPressed: () async {
                  if (controller.titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Title cannot be empty😵‍💫')));
                  } else if (controller.descriptionController.text
                      .trim()
                      .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Description cannot be empty😉')));
                  } else if (controller.selectedImages.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Time capsule is incomplete with your sweet memories✨')));
                  } else if (controller.selectedDate.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Memorable date is a must!❤️')));
                  } else {
                    final data = await controller.createMemory(context);
                    await userController.addTimeCapsule(data);
                    Get.offAndToNamed('/success_screen');
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)),
                child: const Text(
                  'Create a memory',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
