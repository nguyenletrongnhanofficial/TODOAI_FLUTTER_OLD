import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoai/config/config.dart';
import 'package:todoai/providers/task_provider.dart';
import 'package:todoai/providers/user_provider.dart';

class AddTaskClassic extends StatefulWidget {
  const AddTaskClassic({super.key});

  @override
  State<AddTaskClassic> createState() => _AddTaskClassicState();
}
int selectColor = 0;


class _AddTaskClassicState extends State<AddTaskClassic> {
  int selectColor = 0;
   final _dio = Dio();
  TextEditingController titleEditingController = TextEditingController();
TextEditingController timeEditingController = TextEditingController();
TextEditingController dateEditingController = TextEditingController();
TextEditingController describeEditingController = TextEditingController();

late String current_user_id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    current_user_id =
        Provider.of<UserProvider>(context, listen: false).current_user_id;
  }

  Future<void> postTask() async {
    try {
    
      
      String date = DateFormat('dd/MM/yyyy')
          .format(DateFormat('dd.MM.yyyy').parse(dateEditingController.text));

      var response = await _dio.post("$baseUrl/task/addTask", data: {
        "title": titleEditingController.text,
        "date": date,
        "user": current_user_id,
        "color": selectColor,
        "describe":describeEditingController.text,
        "time": timeEditingController.text,
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
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 500,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
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
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Công việc',
                        style:
                            TextStyle(fontSize: 16, fontFamily: "TodoAi-Medium"),
                      ),
                    ),
                    TextFormField(
                      controller: titleEditingController,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: "TodoAi-Book"),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        hintText: "Thêm công việc...",
                        hintStyle:
                            TextStyle(fontSize: 16, fontFamily: "TodoAi-Book"),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      maxLines: null,
                      cursorColor: Colors.black,
                      cursorHeight: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  'Thời gian',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "TodoAi-Medium"),
                                ),
                              ),
                              TextFormField(
                                controller: timeEditingController,
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: "TodoAi-Book"),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    hintText: "hh:mm",
                                    hintStyle: TextStyle(
                                        fontSize: 16, fontFamily: "TodoAi-Book"),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    prefixIcon: Icon(Icons.lock_clock_rounded)),
                                maxLines: null,
                                cursorColor: Colors.black,
                                cursorHeight: 20,
                              ),
                            ],
                          ),
                        ),
                        
                       const Expanded(flex: 1,child: SizedBox.shrink()),
                        Flexible(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  'Ngày',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "TodoAi-Medium"),
                                ),
                              ),
                              TextFormField(
                                controller: dateEditingController,
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: "TodoAi-Book"),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    hintText: "dd.mm.yyyy",
                                    hintStyle: TextStyle(
                                        fontSize: 16, fontFamily: "TodoAi-Book"),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    prefixIcon:
                                        Icon(Icons.calendar_month_rounded)),
                                maxLines: null,
                                cursorColor: Colors.black,
                                cursorHeight: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Màu sắc',
                        style:
                            TextStyle(fontSize: 16, fontFamily: "TodoAi-Medium"),
                      ),
                    ),
                    Stack(children: [
                      Container(
                        height: 40,
                        width: 230,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 228, 228, 228),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Mô tả',
                        style:
                            TextStyle(fontSize: 16, fontFamily: "TodoAi-Medium"),
                      ),
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(
                            color: const Color(0xFFDEE3F2),
                            width: 1,
                          )),
                      child: TextFormField(
                        controller: describeEditingController,
                        style: const TextStyle(
                            fontSize: 16, fontFamily: "TodoAi-Book"),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: "Thêm mô tả...",
                          hintStyle:
                              TextStyle(fontSize: 16, fontFamily: "TodoAi-Book"),
                        ),
                        maxLines: null,
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: postTask,
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(const Size(200, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            Text('Tạo công việc')
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}