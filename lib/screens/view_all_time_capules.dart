import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/utility/texts.dart';
import 'package:time_capsule_app/utility/time_capsule_tile.dart';
import 'package:timelines/timelines.dart';

import '../controllers/user_controller.dart';
import '../modal/time_capsule_model.dart';
import '../utility/time_capsule_card.dart';

class AllTimeCapsulesScreen extends StatefulWidget {
  const AllTimeCapsulesScreen({super.key});

  @override
  State<AllTimeCapsulesScreen> createState() => _AllTimeCapsulesScreenState();
}

class _AllTimeCapsulesScreenState extends State<AllTimeCapsulesScreen> {
  bool isCardView = true;
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hbox(10.0),
              titlewidget(
                context,
                'All time capsules',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Default view'),
                  IconButton(
                    icon: Icon(isCardView ? Icons.view_module : Icons.timeline),
                    onPressed: () {
                      setState(() {
                        isCardView = !isCardView;
                      });
                    },
                  ),
                ],
              ),
              hbox(20.0),
              Expanded(
                child: Obx(
                  () {
                    var sortedTimeCapsules = userController.sortedTimeCapsules;
                    return sortedTimeCapsules.isNotEmpty
                        ? isCardView
                            ? _buildCardView(context, sortedTimeCapsules)
                            : _buildTimelineView(context, sortedTimeCapsules)
                        : Center(
                            child: textwidget(
                                context, 'No time capsules available.'),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardView(BuildContext context, List<TimeCapsule> timeCapsules) {
    return ListView.builder(
      itemCount: timeCapsules.length,
      itemBuilder: (context, index) {
        return timeCapsuleCard(context, timeCapsules[index]);
      },
    );
  }

  Widget _buildTimelineView(
      BuildContext context, List<TimeCapsule> timeCapsules) {
    return Timeline.builder(
      itemCount: timeCapsules.length,
      itemBuilder: (context, index) {
        return timeCapsuleTile(context, timeCapsules[index]);
      },
    );
  }
}
