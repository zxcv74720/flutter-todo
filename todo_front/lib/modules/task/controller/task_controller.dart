import 'package:get/get.dart';
import 'package:todo_front/data/provider/task_provider.dart';

import '../../../data/models/task.dart';

class TaskController extends GetxController {
  RxList<Task> todayTasks = <Task>[].obs;
  RxList<Task> yesterdayTasks = <Task>[].obs;

  void addTask(int id, String taskTitle, DateTime taskDueTime) async {
    Task task = await TaskProvider.addTask(id, taskTitle, taskDueTime);
    todayTasks.add(task);
    update();
  }

  void reAddYesterdayTask(Task task) async {
    await TaskProvider.reAddYesterdayTask(task.id);
    yesterdayTasks.remove(task);
    todayTasks.add(task);
    update();
  }

  void updateTask(Task task) async {
    task.toggle();
    await TaskProvider.updateTask(task.id);
    update();
  }

  void deleteTask(Task task) async {
    await TaskProvider.deleteTask(task.id);
    todayTasks.remove(task);
    update();
  }

  List<Task> sortTasks(List<Task> tasks) {
    List<Task> doneTasks = tasks.where((task) => !task.done).toList();
    List<Task> undoneTasks = tasks.where((task) => task.done).toList();

    doneTasks.sort((a, b) => a.title.compareTo(b.title));
    undoneTasks.sort((a, b) => a.title.compareTo(b.title));

    return [...doneTasks, ...undoneTasks];
  }
}