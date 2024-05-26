import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/utility/texts.dart';

import '../controllers/create_capsule_controller.dart';
import '../controllers/user_controller.dart';
import '../utility/buttons.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Form(
                child: ListView(
                  children: [
                    titlewidget(context, 'Capture Your Cherished Memories ✨'),
                    hbox(30.0),
                    TextFormField(
                      controller: controller.titleController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: 'my first birthday',
                          labelText: 'Enter title ✍🏻'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    hbox(10.0),
                    TextFormField(
                      controller: controller.descriptionController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText:
                              'got my favourite teddy bear and a cool car',
                          labelText: 'Enter description ✍🏻'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    hbox(30.0),
                    textwidget(context, 'Select the date 📅'),
                    ListTile(
                      trailing: IconButton(
                        onPressed: () async {
                          await controller.selectDate(context);
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                      title: Obx(
                        () => textwidget(
                          context,
                          controller.selectedDate.value.isEmpty
                              ? 'No date selected'
                              : controller.selectedDate.value,
                        ),
                      ),
                    ),
                    hbox(30.0),
                    textwidget(
                        context, 'How often do you want to be reminded? ⌚'),
                    GetBuilder<CreateCapsuleController>(
                      builder: (controller) => DropdownButton(
                        value: controller.reminderCriteria,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items:
                            controller.reminderCriteriaItems.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: textwidget(context, item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.updateReminderCriteria(newValue!);
                        },
                      ),
                    ),
                    hbox(30.0),
                    textwidget(context, 'Select your memories 🔗'),
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
                    hbox(10.0),
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).canvasColor),
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Wrap(
                          children: controller.selectedImages.isEmpty
                              ? [
                                  Center(
                                      child: textwidget(
                                          context, 'No photo is selected'))
                                ]
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
                                                  onPressed: () => controller
                                                      .deleteImage(index),
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
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (controller.titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Title cannot be empty')));
                } else if (controller.descriptionController.text
                    .trim()
                    .isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Description cannot be empty')));
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
              style: buttonStyle(Colors.pink),
              child: buttonText('Create Memory'),
            ),
          ],
        ),
      ),
    );
  }
}
