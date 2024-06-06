import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_capsule_app/modal/time_capsule_model_v2.dart';
import 'package:time_capsule_app/screens/utility/texts.dart';

import 'utility/time_capsule_data_processing.dart';

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
        child: ListView(
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
                  formatDate(timeCapsule.date),
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
              children: timeCapsule.memories.map((String memoryURL) {
                // int index = timeCapsule.memories.indexOf(photo);
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
                      child: Image.network(
                        memoryURL,
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
