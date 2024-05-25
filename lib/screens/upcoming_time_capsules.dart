import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/controllers/user_controller.dart';
import 'package:time_capsule_app/screens/view_time_capsule.dart';
import 'package:time_capsule_app/utility/texts.dart';

import '../modal/time_capsule_model.dart';

class UpcomingTimeCapsules extends StatelessWidget {
  UpcomingTimeCapsules({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Obx(
        () => userController.timeCapsules.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userController.timeCapsules.length,
                itemBuilder: (context, index) {
                  return timeCapsuleContainer(
                      context, userController.timeCapsules[index]);
                },
              )
            : Center(
                child: textwidget(
                    context, 'Create your first memory by clicking below!!'),
              ),
      ),
    );
  }

  Widget timeCapsuleContainer(BuildContext context, TimeCapsule timeCapsule) {
    Color stateColor = timeCapsule.memoryState == 'upcoming'
        ? Colors.blueAccent
        : (timeCapsule.memoryState == 'completed'
            ? Colors.greenAccent
            : Colors.amber);

    return GestureDetector(
      onTap: () {
        Get.to(() => DisplayTimeCapsule(timeCapsule: timeCapsule));
      },
      child: Container(
        width: 250.0,
        decoration: BoxDecoration(
          color: stateColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: Text(
                timeCapsule.title,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            ),
            hbox(10.0),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                hbox(16.0),
                Expanded(
                  child: Text(
                    timeCapsule.description ?? "",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
