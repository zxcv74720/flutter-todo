import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';
import 'globals.dart';

// api를 호출하는 프로바이더(공급자) 선언
class TaskProvider extends GetConnect implements GetxService {
  static Future<Task> addTask(String title) async {
    Map data = {
      "title": title,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/add');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    Map responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);

    return task;
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    List responseList = jsonDecode(response.body);
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<http.Response> updateTask(int id) async {
    var url = Uri.parse(baseURL + '/update/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );

    print(response.body);

    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse(baseURL + '/delete/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    print(response.body);

    return response;
  }
}