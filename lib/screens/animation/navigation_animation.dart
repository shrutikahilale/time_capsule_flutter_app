import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NavigationAnimation extends StatefulWidget {
  const NavigationAnimation({super.key});

  @override
  State<NavigationAnimation> createState() => _NavigationAnimationState();
}

class _NavigationAnimationState extends State<NavigationAnimation> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Get.offAndToNamed('/create_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: LoadingAnimationWidget.beat(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
