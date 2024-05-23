import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_capsule_app/screens/animation/navigation_animation.dart';
import 'package:time_capsule_app/screens/animation/success_animation.dart';
import 'package:time_capsule_app/screens/create_time_capsule.dart';
import 'package:time_capsule_app/screens/homepage.dart';

import 'controllers/user_controller.dart';

void main() {
  runApp(const MyApp());
  Get.put(UserController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/create_screen': (context) => CreateScreen(),
        '/navigate_screen': (context) => const NavigationAnimation(),
        '/success_screen': (context) => const SuccessAnimation(),
      },
    );
  }
}
