import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/create_screen': (context) => CreateScreen(),
      },
    );
  }
}
