import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_capsule_app/modal/time_capsule_model.dart';
import 'package:time_capsule_app/utility/texts.dart';

import 'full_screen_view.dart';

class DisplayTimeCapsule extends StatelessWidget {
  final TimeCapsule timeCapsule;

  const DisplayTimeCapsule({super.key, required this.timeCapsule});

  @override
  Widget build(BuildContext context) {
    String title = getRandomMemoryTitle();
    return Scaffold(
      appBar: AppBar(
        title: textwidget(context, title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titlewidget(context, timeCapsule.title),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: 8),
                textwidget(
                  context,
                  _formatDate(timeCapsule.date),
                ),
              ],
            ),
            const SizedBox(height: 20),
            textwidget(
              context,
              timeCapsule.description ?? "",
            ),
            SizedBox(height: timeCapsule.description != null ? 20 : 0),
            ElevatedButton(
              onPressed: () {}, // Add your onPressed function here
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Button shape
                ),
              ),
              child: Text(
                'Reminded: ${timeCapsule.reminderCriteria}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: timeCapsule.memories.map((File photo) {
                int index = timeCapsule.memories.indexOf(photo);
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => FullScreenImageViewer(
                    //       images: timeCapsule.memories,
                    //       initialIndex: index,
                    //     ),
                    //   ),
                    // );
                  },
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        photo.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    List<String> date = dateString.split('/');
    final day = date[0];
    final month = _getMonthName(int.parse(date[1]));
    final year = date[2];

    return '$day $month, $year';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String getRandomMemoryTitle() {
    List<String> titles = [
      "Cherished Moments 💫",
      "Reliving 🔙",
      "Memories Unveiled 🎭",
      "Reminiscing 🤔",
      "Unforgettable 🎉",
      "Capturing the Essence 📸",
      "Revisiting 🔄",
      "Preserving the Memories 📚",
      "Recounting the Moments 📝",
      "Delving into the Memories 🧠",
      "Uncovering the Essence 🔍",
    ];

    Random random = Random();
    int index = random.nextInt(titles.length);
    return titles[index];
  }
}
