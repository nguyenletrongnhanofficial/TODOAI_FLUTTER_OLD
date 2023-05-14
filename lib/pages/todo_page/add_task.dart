import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoai/config/config.dart';
import 'package:todoai/pages/todo_page/add_task_classic.dart';
import 'package:todoai/pages/todo_page/todo_page.dart';
import 'package:todoai/providers/task_provider.dart';
import 'package:todoai/providers/user_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  int selectColor = 0;
  final _focusNode = FocusNode();
  final _dio = Dio();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gọi requestFocus() khi widget được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode
        .dispose(); // Đảm bảo giải phóng FocusNode khi không cần thiết nữa
    super.dispose();
  } // Tạo FocusNode mới

  late String current_user_id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    current_user_id =
        Provider.of<UserProvider>(context, listen: false).current_user_id;
  }

  Future<void> postTask() async {
    try {
      RegExp timePattern = RegExp(r'\/(\d{1,2}:\d{2})?');
      RegExp datePattern = RegExp(r'(\d{1,2}\.\d{1,2}\.\d{4})');
      RegExp descPattern = RegExp(r'\/\/(.*)');

      String title = textEditingController.text.split('/').first.trim();
      String time =
          timePattern.firstMatch(textEditingController.text)?.group(1) ?? '';
      String dateInput =
          datePattern.firstMatch(textEditingController.text)?.group(1) ?? '';
      String description =
          descPattern.firstMatch(textEditingController.text)?.group(1) ?? '';
      if (dateInput.isEmpty) {
        dateInput = DateFormat('dd.MM.yyyy').format(DateTime.now());
      }

      if (description.isEmpty) {
        description = 'Không có mô tả';
      }
      if (time.isEmpty) {
        time = " ";
      }
      String date = DateFormat('dd/MM/yyyy')
          .format(DateFormat('dd.MM.yyyy').parse(dateInput));

      var response = await _dio.post("$baseUrl/task/addTask", data: {
        "title": title,
        "date": date,
        "user": current_user_id,
        "color": selectColor,
        "describe": description,
        "time": time,
      });
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Provider.of<TaskProvider>(context, listen: false)
            .getAllTask(current_user_id);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D0140),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Thêm công việc',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'TodoAi-Medium'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: textEditingController,
              focusNode: _focusNode,
              style: const TextStyle(fontSize: 16, fontFamily: "TodoAi-Book"),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                hintText: "Việc mới cần làm",
                hintStyle: TextStyle(fontSize: 16, fontFamily: "TodoAi-Book"),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              maxLines: null,
              cursorColor: Colors.black,
              cursorHeight: 20,
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: const [
                Text(
                  'Ví dụ cú pháp:',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  ' họp nhóm/21:30 21.04.2023//chủ đề về ăn uống',
                  style: TextStyle(fontSize: 10, fontFamily: "TodoAi-Book"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Màu sắc',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Stack(children: [
                    Container(
                      height: 40,
                      width: 230,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 228, 228),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 3,
                      child: Wrap(
                        children: List<Widget>.generate(7, (int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: index == 0
                                    ? Colors.red
                                    : index == 1
                                        ? Colors.yellow
                                        : index == 2
                                            ? Colors.green
                                            : index == 3
                                                ? Colors.blue
                                                : index == 4
                                                    ? Colors.pinkAccent
                                                    : index == 5
                                                        ? Colors.deepPurple
                                                        : Colors.black,
                                child: selectColor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    showGeneralDialog(
                        barrierLabel: "Barrier",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: const Duration(milliseconds: 400),
                        context: context,
                        pageBuilder: (_, __, ___) {
                          return AddTaskClassic();
                        },
                        transitionBuilder: (_, anim, __, child) {
                          Tween<Offset> tween;

                          // if (anim.status == AnimationStatus.reverse) {
                          //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                          // } else {
                          //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
                          // }

                          tween = Tween(
                              begin: const Offset(0, 1), end: Offset.zero);

                          return SlideTransition(
                            position: tween.animate(
                              CurvedAnimation(
                                  parent: anim, curve: Curves.easeInOut),
                            ),
                            //mờ
                            // child: FadeTransition(
                            //   opacity: anim,
                            //   child: child,
                            // ),
                            child: child,
                          );
                        });
                  },
                  child: const Text(
                    'Đặt lịch cổ điển',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Text(
                        'Sử dụng Al',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Image.asset('assets/icons/icon_ai.png')
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 35,
                        onPressed: postTask,
                        icon: Image.asset('assets/icons/done_icon.gif'),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 5))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
