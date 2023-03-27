import 'package:flutter/material.dart';
import '/models/course.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';
import 'package:provider/provider.dart';
import '/providers/card_profile_provider.dart';
import '/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();
  factory CurrentUser() => _instance;
  CurrentUser._internal();

  late String current_user_id;
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    final userCurrent = Provider.of<CardProfileProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã đăng nhập thành công✅",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    "Bên dưới là thông tin tài khoản của bạn đã call được từ API Nodejs",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    height: 1.5,
                    color: const Color.fromRGBO(222, 225, 231, 1),
                  ),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Tên: "),
                      Text(
                        '${userCurrent?.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "TodoAi-Medium"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Số điện thoại: "),
                      Text(
                        '${userCurrent?.phone}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "TodoAi-Medium"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
