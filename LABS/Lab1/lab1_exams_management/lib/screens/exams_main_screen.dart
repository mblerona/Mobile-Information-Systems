import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../models/hardcoded_exams.dart';
import 'details_screen.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    examsList.sort((a, b) => a.examTime.compareTo(b.examTime));

    const darkBlue = Color(0xFF0D47A1);
    const redStripe = Colors.red;
    const greenStripe = Colors.green;

    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Распоред на испити - 221541',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkBlue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          children: [

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: redStripe,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Past exams',
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),

                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: greenStripe,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Upcoming exams',
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            Expanded(
              child: ListView.builder(
                itemCount: examsList.length,
                itemBuilder: (context, index) {
                  final exam = examsList[index];
                  final isPast = exam.examTime.isBefore(now);

                  return Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ExamDetailScreen(exam: exam),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [

                            Container(
                              width: 8,
                              height: 90,
                              decoration: BoxDecoration(
                                color: isPast ? redStripe : greenStripe,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                            ),


                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Subject
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        exam.subject,
                                        style: const TextStyle(
                                          color: darkBlue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),


                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              const Icon(Icons.calendar_today,
                                                  size: 16, color: darkBlue),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${exam.examTime.day}.${exam.examTime.month}.${exam.examTime.year}',
                                                style: const TextStyle(
                                                    color: darkBlue),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              const Icon(Icons.access_time,
                                                  size: 16, color: darkBlue),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${exam.examTime.hour.toString().padLeft(2, '0')}:${exam.examTime.minute.toString().padLeft(2, '0')}',
                                                style: const TextStyle(
                                                    color: darkBlue),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              const Icon(Icons.meeting_room,
                                                  size: 16, color: darkBlue),
                                              const SizedBox(width: 4),
                                              Text(
                                                exam.examRooms.join(', '),
                                                style: const TextStyle(
                                                    color: darkBlue),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: darkBlue,
        padding: const EdgeInsets.all(12),
        child: Text(
          'Вкупно испити: ${examsList.length}',
          textAlign: TextAlign.center,
          style: const TextStyle(

            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
