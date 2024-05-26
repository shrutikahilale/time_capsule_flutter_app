import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/controllers/user_controller.dart';
import 'package:time_capsule_app/utility/texts.dart';

import '../utility/time_capsule_card.dart';
import 'view_all_time_capules.dart';

class UpcomingTimeCapsules extends StatelessWidget {
  UpcomingTimeCapsules({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
          height: 250,
          child: Obx(() {
            var sortedTimeCapsules = userController.sortedTimeCapsules;
            return sortedTimeCapsules.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if (sortedTimeCapsules.length > 3 && index == 3) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => const AllTimeCapsulesScreen());
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              backgroundColor: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              height: double.infinity,
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textwidget(context, 'View All'),
                                  hbox(10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Icon(
                                      Icons.navigate_next_outlined,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (index < sortedTimeCapsules.length) {
                          return timeCapsuleCard(
                            context,
                            sortedTimeCapsules[index],
                          );
                        } else {
                          return hbox(0.0);
                        }
                      }
                    },
                  )
                : Center(
                    child: textwidget(context,
                        'Create your first memory by clicking below!!'),
                  );
          }),
        ),
      ],
    );
  }
}
