import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:time_capsule_app/screens/animation/navigation_animation.dart';
import 'package:time_capsule_app/screens/animation/success_animation.dart';
import 'package:time_capsule_app/screens/create_time_capsule.dart';
import 'package:time_capsule_app/screens/homepage.dart';

import 'controllers/user_controller.dart';
import 'theme/theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
  Get.put(UserController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: themeNotifier.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/create_screen': (context) => CreateScreen(),
            '/navigate_screen': (context) => const NavigationAnimation(),
            '/success_screen': (context) => const SuccessAnimation(),
          },
        );
      },
    );
  }
}
