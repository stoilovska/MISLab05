import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamWidget extends StatefulWidget {
  final Function(Exam) addExam;

  const ExamWidget({required this.addExam, super.key});

  @override
  ExamWidgetState createState() => ExamWidgetState();
}

class ExamWidgetState extends State<ExamWidget> {
  final TextEditingController subjectController = TextEditingController();
  DateTime choseDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _chooseDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: choseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (datePicked != null && datePicked != choseDate) {
      setState(() {
        choseDate = datePicked;
      });
    }
  }

  void _chooseTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(choseDate),
    );

    if (timePicked != null && timePicked != selectedTime) {
      setState(() {
        choseDate = DateTime(
          choseDate.year,
          choseDate.month,
          choseDate.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Date: ${choseDate.toLocal().toString().split(' ')[0]}'),
                ElevatedButton(
                  child: const Text('Choose Date'),
                  onPressed: () => _chooseDate(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Time: ${choseDate.toLocal().toString().split(' ')[1].substring(0, 5)}'),
                ElevatedButton(
                  onPressed: () => _chooseTime(context),
                  child: const Text('Choose Time'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Exam exam = Exam(
                  subject: subjectController.text,
                  dateTime: choseDate,
                );
                widget.addExam(exam);
                Navigator.pop(context);
              },
              child: const Text('Add Exam'),
            ),
          ],
        ),
      ),
    );
  }
}