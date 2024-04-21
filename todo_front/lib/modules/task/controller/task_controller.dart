import 'package:get/get.dart';
import 'package:todo_front/data/provider/task_provider.dart';

import '../../../data/models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  void addTask(String taskTitle, DateTime taskDueTime) async {
    Task task = await TaskProvider.addTask(taskTitle, taskDueTime);
    tasks.add(task);
    update();
  }

  void updateTask(Task task) async {
    task.toggle();
    await TaskProvider.updateTask(task.id);
    update();
  }

  void deleteTask(Task task) async {
    await TaskProvider.deleteTask(task.id);
    tasks.remove(task);
    update();
  }
}