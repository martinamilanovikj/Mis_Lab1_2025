import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';
import 'exam_detail_screen.dart';

class ExamsListScreen extends StatelessWidget {
  const ExamsListScreen({Key? key}) : super(key: key);

  List<Exam> _generateExams() {
    return [
      Exam(subjectName: "Алгоритми и податочни структури", dateTime: DateTime(2025, 1, 12, 9, 0), rooms: ["Lab138", "Lab200AB"]),
      Exam(subjectName: "Бази на податоци", dateTime: DateTime(2025, 1, 14, 12, 0), rooms: ["Lab3"]),
      Exam(subjectName: "Веб програмирање", dateTime: DateTime(2025, 1, 18, 10, 0), rooms: ["Lab13"]),
      Exam(subjectName: "Оперативни системи", dateTime: DateTime(2025, 1, 10, 8, 30), rooms: ["Lab117"]),
      Exam(subjectName: "Мрежни технологии", dateTime: DateTime(2025, 1, 20, 11, 0), rooms: ["Lab2"]),
      Exam(subjectName: "Машинско учење", dateTime: DateTime(2025, 2, 2, 9, 0), rooms: ["Lab1"]),
      Exam(subjectName: "Софтверско инженерство", dateTime: DateTime(2025, 11, 25, 13, 0), rooms: ["Lab200B"]),
      Exam(subjectName: "Вештачка интелигенција", dateTime: DateTime(2025, 11, 28, 9, 0), rooms: ["Lab2"]),
      Exam(subjectName: "Компјутерска графика", dateTime: DateTime(2025, 12, 15, 10, 30), rooms: ["AMF"]),
      Exam(subjectName: "Математика 3", dateTime: DateTime(2025, 12, 20, 9, 0), rooms: ["Lab215"]),
    ]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    final exams = _generateExams();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Распоред за испити'),
        centerTitle: true,
        backgroundColor: Colors.teal[600],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            final exam = exams[index];
            final isPast = exam.dateTime.isBefore(DateTime.now());

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.black38,
              color: isPast ? Colors.grey[200] : Colors.teal[100],
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  exam.subjectName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.teal),
                        const SizedBox(width: 6),
                        Text(DateFormat('dd.MM.yyyy – HH:mm').format(exam.dateTime)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.meeting_room, size: 16, color: Colors.blueGrey),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            exam.rooms.join(', '),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamDetailScreen(exam: exam)),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Вкупно испити: ${exams.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
