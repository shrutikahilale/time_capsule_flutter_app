import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/utility/texts.dart';
import 'package:time_capsule_app/utility/time_capsule_data_processing.dart';

import '../modal/time_capsule_model.dart';
import '../screens/view_time_capsule.dart';

Widget timeCapsuleCard(BuildContext context, TimeCapsule timeCapsule) {
  Color stateColor = getStateColor(timeCapsule.memoryState);
  String imagePath = getReminderCriteriaImagePath(timeCapsule.reminderCriteria);

  return GestureDetector(
    onTap: () {
      Get.to(() => DisplayTimeCapsule(timeCapsule: timeCapsule));
    },
    child: Container(
      width: 300.0,
      decoration: BoxDecoration(
        color: stateColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  timeCapsule.title,
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
              ),
              Image.asset(
                imagePath,
                height: 50.0,
              ),
            ],
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
              wbox(10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeCapsule.description ?? "",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 4,
                    ),
                    hbox(8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Colors.white,
                        ),
                        wbox(8.0),
                        Text(
                          timeCapsule.date,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
