import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF0D47A1);

    final Duration remaining = exam.remainingTime;
    String remainingText;

    if (exam.passedExam) {
      remainingText = 'Испитот е поминат :(';
    } else {
      int days = remaining.inDays;
      int hours = remaining.inHours % 24;
      remainingText = 'Време до испитот: $days ден/а, $hours часа';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Детали за испитот',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: darkBlue,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40), // ⬅️ adds top space
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exam.subject,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: darkBlue),
                const SizedBox(width: 8),
                Text(
                  '${exam.examTime.day}.${exam.examTime.month}.${exam.examTime.year}',
                  style: const TextStyle(fontSize: 16, color: darkBlue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, color: darkBlue),
                const SizedBox(width: 8),
                Text(
                  '${exam.examTime.hour.toString().padLeft(2, '0')}:${exam.examTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16, color: darkBlue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.meeting_room, color: darkBlue),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    exam.examRooms.join(', '),
                    style: const TextStyle(fontSize: 16, color: darkBlue),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              remainingText,
              style: TextStyle(
                fontSize: 16,
                color: exam.passedExam ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),


      bottomNavigationBar: Container(
        color: darkBlue,
        padding: const EdgeInsets.all(12),
        child: Text(
          '${exam.subject}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
