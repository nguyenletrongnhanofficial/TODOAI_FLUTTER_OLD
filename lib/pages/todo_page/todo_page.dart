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
  late String current_user_id;
  final CurrentUser _currentUser = CurrentUser();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentUser.current_user_id =
        Provider.of<UserProvider>(context, listen: false).current_user_id;
    Provider.of<CardProfileProvider>(context)
        .fetchCurrentUser(_currentUser.current_user_id);
    Provider.of<TaskProvider>(context).getAllTask(_currentUser.current_user_id);
  }

  //
  final focusNode = FocusNode();
  final _dio = Dio();

  @override
  Widget build(BuildContext context) {
    final userCurrent = Provider.of<CardProfileProvider>(context).user;
    int x = 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<TaskProvider>(
          builder: (context, taskData, child) => Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 5),
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
                      height: 60,
                      width: 45,
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
              const CalendarMonth(),
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
                        'Bạn có ${taskData.task.length} công việc cần làm trong hôm nay')
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 280,
                child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskData.task.length,
                      itemBuilder: (context, index) {
                        Task _task = taskData.task[index];
                        if (_task.isComplete) {
                          return const SizedBox.shrink();
                        } else {
                          return ListItemWidget(
                              task: _task,
                              onClicked: () => {
                                    _dio.put(
                                        "$baseUrl/task/updateTask/${taskData.task[index].id}",
                                        data: {"isComplete": true}),
                                  });
                          ;
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
                      if (_task.isComplete) {
                        return ListItemWidget(
                          task: _task,
                          onClicked: () => {
                            _dio.put(
                                "$baseUrl/task/updateTask/${taskData.task[index].id}",
                                data: {"isComplete": false}),
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
