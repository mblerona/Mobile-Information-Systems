class Exam{
  String subject;
  DateTime examTime;
  List<String> examRooms;

  Exam({
    required this.subject,
    required this.examTime,
    required this.examRooms,

  });

  bool get passedExam => examTime.isBefore(DateTime.now());
  bool get futureExam => examTime.isAfter(DateTime.now());

  Duration get remainingTime => examTime.difference(DateTime.now());
}