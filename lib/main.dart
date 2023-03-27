
import 'package:flutter/material.dart';
import 'package:todoai/pages/todo_page/todo_page.dart';
import 'pages/entryPoint/entry_point.dart';
import 'pages/onboding/onboding_screen.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import 'providers/card_profile_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();




final screens = [];
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider()),
    ChangeNotifierProvider.value(value: CardProfileProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "TodoAi-Bold",
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: const OnbodingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
