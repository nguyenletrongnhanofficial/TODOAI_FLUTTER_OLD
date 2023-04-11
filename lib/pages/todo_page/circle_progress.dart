import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todoai/models/task.dart';
import 'package:todoai/providers/task_provider.dart';
import 'package:todoai/pages/todo_page/date_model.dart' as date_util;

class CircleProgress extends StatefulWidget {
  const CircleProgress({super.key});

  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

persenDay(List<Task> list, String date) {
  double countComplete = 0;
  double countTask = 0;
  double none = 1;
  if (list.isEmpty) {
    return none;
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i].date == date) {
      countTask++;
    }
  }
  for (int i = 0; i < list.length; i++) {
    if (list[i].isComplete == true && list[i].date == date) {
      countComplete++;
    }
  }
  return countComplete / countTask;
}

persenWeek(List<Task> list, List<DateTime> currentWeek) {
  double countComplete = 0;
  double countTask = 0;
  double none = 1;
  if (list.isEmpty) {
    return none;
  }
  for (int i = 0; i < currentWeek.length; i++) {
    String dateFormat = DateFormat('dd/MM/yyyy').format(currentWeek[i]);

    for (int j = 0; j < list.length; j++) {
      if (list[j].date == dateFormat) {
        countTask++;
      }
    }
  }

  for (int i = 0; i < currentWeek.length; i++) {
    String dateFormat = DateFormat('dd/MM/yyyy').format(currentWeek[i]);

    for (int j = 0; j < list.length; j++) {
      if (list[j].date == dateFormat && list[j].isComplete == true) {
        countComplete++;
      }
    }
  }
  return countComplete / countTask;
}

persenMonth(List<Task> list, List<DateTime> currentMonth) {
  double countComplete = 0;
  double countTask = 0;
  double none = 1;
  if (list.isEmpty) {
    return none;
  }
  for (int i = 0; i < currentMonth.length; i++) {
    String date =
        '${currentMonth[i].day}/${DateTime.now().month}/${DateTime.now().year}';
    String dateFormat = DateFormat('dd/MM/yyyy')
        .format(DateFormat('dd/MM/yyyy').parse(date))
        .toString();
    for (int j = 0; j < list.length; j++) {
      if (list[j].date == dateFormat) {
        countTask++;
      }
    }
  }

  for (int i = 0; i < currentMonth.length; i++) {
    String date =
        '${currentMonth[i].day}/${DateTime.now().month}/${DateTime.now().year}';
    String dateFormat = DateFormat('dd/MM/yyyy')
        .format(DateFormat('dd/MM/yyyy').parse(date))
        .toString();
    for (int j = 0; j < list.length; j++) {
      if (list[j].date == dateFormat && list[j].isComplete == true) {
        countComplete++;
      }
    }
  }
  return countComplete / countTask;
}

class _CircleProgressState extends State<CircleProgress> {
  DateTime currentDateTime = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();

    super.initState();
  }

  List<DateTime> currentWeekDays() {
    DateTime now = DateTime.now();
    int currentDayOfWeek = now.weekday;
    List<DateTime> days = [];

    for (int i = 1; i <= 7; i++) {
      DateTime day = now.add(Duration(days: i - currentDayOfWeek));
      days.add(day);
    }

    return days;
  }

  final String dateNowFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
        builder: (context, taskData, child) => Container(
              height: 70,
              color: Colors.transparent,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Đã hoàn thành'),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularPercentIndicator(
                        radius: 28,
                        percent: persenDay(taskData.task, dateNowFormat),
                        progressColor: const Color(0xFF00FF8A),
                        backgroundColor: Colors.lightGreen.shade100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${(persenDay(taskData.task, dateNowFormat) * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF00FF8A),
                              ),
                            ),
                            const Text(
                              'Ngày',
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF00FF8A)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircularPercentIndicator(
                        radius: 28,
                        percent: persenWeek(taskData.task, currentWeekDays()),
                        progressColor: Colors.deepPurple,
                        backgroundColor: Colors.deepPurple.shade100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${(persenWeek(taskData.task, currentWeekDays()) * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const Text(
                              'Tuần',
                              style: TextStyle(
                                  fontSize: 8, color: Colors.deepPurple),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircularPercentIndicator(
                        radius: 28,
                        percent: persenMonth(taskData.task, currentMonthList),
                        progressColor: Colors.red,
                        backgroundColor: Colors.red.shade100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${(persenMonth(taskData.task, currentMonthList) * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                            const Text(
                              'Tháng',
                              style: TextStyle(fontSize: 8, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
                ],
              ),
            ));
  }
}
