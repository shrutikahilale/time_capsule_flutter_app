import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_app/controllers/user_controller.dart';
import 'package:time_capsule_app/screens/upcoming_time_capsules.dart';
import 'package:time_capsule_app/services/auth_service.dart';

import 'theme/app_themedata.dart';
import 'theme/theme_notifier.dart';
import 'utility/buttons.dart';
import 'utility/texts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  hbox(10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titlewidget(context, 'Hi, there 👋'),
                        IconButton(
                          onPressed: () {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .switchTheme();
                          },
                          icon:
                              Provider.of<ThemeNotifier>(context, listen: false)
                                          .currentTheme ==
                                      darkTheme
                                  ? const Icon(Icons.sunny)
                                  : const Icon(Icons.brightness_2),
                        ),
                      ],
                    ),
                  ),
                  hbox(20.0),
                  headingwidget(context, 'Upcoming Memories'),
                  const SizedBox(height: 12.0),
                  UpcomingTimeCapsules(),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                await Get.offAndToNamed('/create_screen');
              },
              style: buttonStyle(Colors.amber.shade700),
              child: buttonText('Create Memory'),
            ),
            TextButton(
              onPressed: () async {
                AuthService auth = AuthService();
                await auth.signOut();
              },
              style: buttonStyle(Colors.grey[900]),
              child: buttonText('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
