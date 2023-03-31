import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoai/models/task.dart';
import 'package:todoai/models/task_model.dart';
import 'dart:core';
import 'package:todoai/pages/todo_page/calendar_month.dart';
import 'package:todoai/pages/todo_page/circle_progress.dart';
import 'package:todoai/pages/todo_page/list_item_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
//
import 'package:flutter/material.dart';
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
  }

  //
  final list1Key = GlobalKey<AnimatedListState>();
  final list2Key = GlobalKey<AnimatedListState>();
  final List<ListTask> tasks = List.from(listTask);
  final List<ListTask> taskSucces = List.from(listTaskSucces);

  @override
  Widget build(BuildContext context) {
    final userCurrent = Provider.of<CardProfileProvider>(context).user;
    int x = 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 70,
              child: Row(
                children: [
                  const SizedBox(width: 5),
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
                                  border:
                                      Border.all(color: Colors.white, width: 1),
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
                  Container(
                    height: 60,
                    width: 100,
                    margin: const EdgeInsets.only(top: 15, right: 10),
                    child: Column(
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/icons/search_icon.png'),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/icons/notify_icon.png'),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 5))
                      ],
                    ),
                  ),
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
                  Text('Bạn có $x công việc cần làm trong hôm nay')
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: AnimatedList(
                  shrinkWrap: true,
                  key: list1Key,
                  initialItemCount:
                      tasks.length,
                  itemBuilder: (context, index, animation) {
                    
                    if (tasks[index].isComplete) {
                      return const SizedBox.shrink();
                    } else {
                      return ListItemWidget(
                        task: tasks[index],
                        animation: animation,
                        onClicked: () => handleListItemClick(index),
                      );
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircleProgress(),
            SizedBox(
              child: AnimatedList(
                  shrinkWrap: true,
                  key: list2Key,
                  initialItemCount:
                      tasks.length,
                  itemBuilder: (context, index, animation) {
                    
                    if (tasks[index].isComplete) {
                      return ListItemWidget(
                        task: tasks[index],
                        animation: animation,
                        onClicked: () => handleListItemClick(index),
                      );
                    } else {
                      
                      return const SizedBox.shrink();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset('assets/icons/Add_icon.png'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void removeTask(int index) {
    final removeTask = tasks[index];

    tasks.removeAt(index);
    list1Key.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
          animation: animation, task: removeTask, onClicked: () {}),
    );
  }

  void handleListItemClick(int index) {
    setState(() {
      tasks[index].isComplete = !tasks[index].isComplete;
    });
  }
}
