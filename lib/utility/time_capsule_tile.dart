import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/utility/texts.dart';
import 'package:time_capsule_app/utility/time_capsule_data_processing.dart';
import 'package:timelines/timelines.dart';

import '../modal/time_capsule_model.dart';
import '../screens/view_time_capsule.dart';

Widget timeCapsuleTile(BuildContext context, TimeCapsule timeCapsule) {
  Color stateColor = getStateColor(timeCapsule.memoryState);

  return GestureDetector(
    onTap: () {
      Get.to(() => DisplayTimeCapsule(timeCapsule: timeCapsule));
    },
    child: TimelineTile(
      oppositeContents: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(timeCapsule.date),
      ),
      contents: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: textwidget(context, timeCapsule.title),
        ),
      ),
      node: TimelineNode(
        indicator: DotIndicator(
          color: stateColor,
        ),
        startConnector:
            SolidLineConnector(color: Theme.of(context).iconTheme.color),
        endConnector:
            SolidLineConnector(color: Theme.of(context).iconTheme.color),
      ),
    ),
  );
}
