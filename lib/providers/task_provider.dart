import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todoai/config/config.dart';
import 'package:todoai/models/task.dart';

class TaskProvider with ChangeNotifier {
  final _dio = Dio();
  List<Task> _task = [];
  List<Task> get task => _task;

  Future<void> getAllTask(String userId) async {
    try {
      var result = await _dio.get("$baseUrl/auth/getUser/$userId");
      Map<String, dynamic> data = result.data as Map<String, dynamic>;

      var taskServer = data["message"]["tasks"];
      _task.clear();
      for (int i = 0; i < taskServer.length; i++) {
        _task.add(Task.toTask(taskServer[i] as Map<String, dynamic>));
      }
      notifyListeners();
    } catch (e) {
      _task = [];
      notifyListeners();
    }
  }
}
