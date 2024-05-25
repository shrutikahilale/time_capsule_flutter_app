import 'package:flutter/material.dart';

Color getStateColor(String memoryState) {
  switch (memoryState) {
    case 'upcoming':
      return Colors.blueAccent;
    case 'completed':
      return Colors.green;
    case 'ongoing':
      return Colors.amber;
    default:
      return Colors.grey; // Fallback color
  }
}
