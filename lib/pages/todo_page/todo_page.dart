import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoai/config/config.dart';
import 'package:todoai/models/task.dart';
import 'package:todoai/pages/todo_page/addTask.dart';
import 'dart:core';
import 'package:todoai/pages/todo_page/calendar_month.dart';
import 'package:todoai/pages/todo_page/circle_progress.dart';
import 'package:todoai/pages/todo_page/list_item_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
//
import 'package:flutter/material.dart';
import 'package:todoai/providers/task_provider.dart';
import '/models/course.dart';
import 'package:provider/provider.dart';
import '/providers/card_profile_provider.dart';
import '/providers/user_provider.dart';
//

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

//

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();
  factory CurrentUser() => _instance;
  CurrentUser._internal();

  late String current_user_id;
}

//
class _TodoPageState extends State<TodoPage> {
  //
  final _dio = Dio();
  late String current_user_id;
  final CurrentUser _currentUser = CurrentUser();
  bool _isFirstLoad = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {});
      _currentUser.current_user_id =
          Provider.of<UserProvider>(context, listen: false).current_user_id;
      Provider.of<CardProfileProvider>(context, listen: false)
          .fetchCurrentUser(_currentUser.current_user_id);
      Provider.of<TaskProvider>(context, listen: false)
          .getAllTask(_currentUser.current_user_id);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  DateTime _selectedDateTime = DateTime.now();
  void _handleDateTimeChanged(DateTime newDateTime) {
    setState(() {
      _selectedDateTime = newDateTime;
    });
  }

  countTaskDontComplete(List<Task> list, String date) {
    int countTask = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].isComplete == false && list[i].date == date) {
        countTask++;
      }
    }
    return countTask;
  }

  @override
  Widget build(BuildContext context) {
    final userCurrent = Provider.of<CardProfileProvider>(context).user;
    int x = 3;
    final String dateFormat =
        DateFormat('dd/MM/yyyy').format(_selectedDateTime);

    final String dateNowFormat = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<TaskProvider>(
          builder: (context, taskData, child) => Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 15),
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Xin chào 👋',
                            style: TextStyle(
                                fontFamily: 'TodoAi-Book', fontSize: 15),
                          ),
                          Text(
                            '${userCurrent?.name}',
                            style: const TextStyle(
                                fontFamily: 'TodoAi-Bold', fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 65,
                      width: 50,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          const Positioned(
                            height: 45,
                            bottom: 8,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/icons/avatar.png'),
                            ),
                          ),
                          Positioned(
                              bottom: 2,
                              right: 0,
                              child: Container(
                                height: 18,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    color: Colors.green),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Image.asset('assets/icons/iconVector.png'),
                                    const SizedBox(width: 2),
                                    const Text(
                                      '9',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'TodoAi-Bold',
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              CalendarMonth(onDateTimeChanged: _handleDateTimeChanged),           
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 25,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset('assets/icons/loudspeaker_icon.png'),
                    Text(
                        'Bạn có ${countTaskDontComplete(taskData.task, dateNowFormat)} công việc cần làm trong hôm nay')
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 280,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskData.task.length,
                      itemBuilder: (context, index) {
                        Task _task = taskData.task[index];
                        if (_task.isComplete == false &&
                            _task.date == dateFormat) {
                          return ListItemWidget(
                              task: _task,
                              onClicked: () => {
                                    _dio.put(
                                        "$baseUrl/task/updateTask/${taskData.task[index].id}",
                                        data: {"isComplete": true}),
                                    Provider.of<TaskProvider>(context,
                                            listen: false)
                                        .getAllTask(
                                            _currentUser.current_user_id)
                                  });
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ),
              ),
              const CircleProgress(),
              SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskData.task.length,
                    itemBuilder: (context, index) {
                      Task _task = taskData.task[index];
                      if (_task.isComplete == true &&
                          _task.date == dateFormat) {
                        return ListItemWidget(
                          task: _task,
                          onClicked: () => {
                            _dio.put(
                                "$baseUrl/task/updateTask/${taskData.task[index].id}",
                                data: {"isComplete": false}),
                            Provider.of<TaskProvider>(context, listen: false)
                                .getAllTask(_currentUser.current_user_id)
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return AddTask();
              });
        },
        child: Image.asset('assets/icons/Add_icon.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
