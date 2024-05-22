import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule_app/controllers/user_controller.dart';
import 'package:time_capsule_app/screens/upcoming_time_capsules.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Time Capsule App',
        ),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(color: Colors.black),
        child: ListView(
          children: [
            const Text(
              'Upcoming Memories',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0,
            ),
            UpcomingTimeCapsules(),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                await Get.toNamed('/create_screen');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.amber.shade700),
              ),
              child: const Text(
                'Create Memory',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
