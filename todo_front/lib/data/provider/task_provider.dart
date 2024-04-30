import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';
import '../models/user_info.dart';
import 'globals.dart';

// api를 호출하는 프로바이더(공급자) 선언
class TaskProvider extends GetConnect implements GetxService {
  static const String taskURL = '$baseURL/tasks';

  static Future<List<Task>> getTodayTasksByUserInfoId(int id) async {
    var url = Uri.parse('$taskURL/today/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    List responseList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<List<Task>> getYesterdayTasksByUserInfoId(int id) async {
    var url = Uri.parse('$taskURL/yesterday/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    List responseList = jsonDecode(utf8.decode(response.bodyBytes));
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<Task> addTask(int id, String title, DateTime dueTime) async {
    Map<String, dynamic> data = {
      "userInfoId": id,
      "title": title,
      "dueTime": dueTime.toIso8601String(),
    };

    var body = json.encode(data);
    print(body);
    var url = Uri.parse(taskURL + '/add');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);

    return task;
  }

  static Future<http.Response> reAddYesterdayTask(int id) async {
    var url = Uri.parse(taskURL + '/reAdd/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );

    print(response.body);

    return response;
  }

  static Future<http.Response> updateTask(int id) async {
    var url = Uri.parse(taskURL + '/update/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );

    print(response.body);

    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse(taskURL + '/delete/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    print(response.body);

    return response;
  }
}
