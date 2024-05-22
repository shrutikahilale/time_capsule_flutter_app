import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/controllers/user_controller.dart';
import 'package:time_capsule_app/screens/view_time_capsule.dart';

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
                      userController.timeCapsules[index]);
                },
              )
            : const Center(
                child: Text(
                'Create your first memory by clicking below!!',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
              )),
      ),
    );
  }

  Widget timeCapsuleContainer(TimeCapsule timeCapsule) {
    Color stateColor = timeCapsule.memoryState == 'upcoming'
        ? Colors.blue
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
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white, width: 1.0),
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
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Image.asset(
                  'assets/images/img.jpeg',
                  height: 100.0,
                ),
                const SizedBox(
                  width: 16.0,
                ),
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
