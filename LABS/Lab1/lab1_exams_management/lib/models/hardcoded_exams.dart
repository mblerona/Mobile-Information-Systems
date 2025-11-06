import 'exam.dart';

List<Exam> examsList = [
  Exam(
    subject: 'MIS',
    examTime: DateTime(2025, 11, 3, 9, 0), // past (2 days ago)
    examRooms: ['Lab12', 'Lab215'],
  ),
  Exam(
    subject: 'Databases',
    examTime: DateTime(2025, 11, 7, 10, 0), // future (+2 days)
    examRooms: ['Lab318'],
  ),
  Exam(
    subject: 'Computer Networks',
    examTime: DateTime(2025, 11, 1, 8, 30), // past (4 days ago)
    examRooms: ['Lab117', 'AMF MF'],
  ),
  Exam(
    subject: 'Operating Systems',
    examTime: DateTime(2025, 11, 10, 9, 30), // future (+5 days)
    examRooms: ['AMF FINKI', 'Lab215'],
  ),
  Exam(
    subject: 'Web Programming',
    examTime: DateTime(2025, 11, 12, 11, 0), // future (+7 days)
    examRooms: ['Lab13'],
  ),
  Exam(
    subject: 'Mobile Platforms Programming',
    examTime: DateTime(2025, 11, 15, 10, 30), // future (+10 days)
    examRooms: ['Lab117'],
  ),
  Exam(
    subject: 'Artificial Intelligence',
    examTime: DateTime(2025, 10, 31, 12, 0), // past (5 days ago)
    examRooms: ['B1.1'],
  ),
  Exam(
    subject: 'Data Science',
    examTime: DateTime(2025, 11, 18, 9, 0), // future (+13 days)
    examRooms: ['B3.2', 'B2.2'],
  ),
  Exam(
    subject: 'Human-Computer Interaction Design',
    examTime: DateTime(2025, 11, 20, 8, 0), // future (+15 days)
    examRooms: ['Lab200ab'],
  ),
  Exam(
    subject: 'Probability and Statistics',
    examTime: DateTime(2025, 11, 25, 13, 0), // future (+20 days)
    examRooms: ['Lab200a'],
  ),
];
