import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_front/modules/task/controller/task_controller.dart';

import '../../../data/models/task.dart';

class TodayTaskTile extends StatelessWidget {
  final Task task;
  final TaskController taskController;

  const TodayTaskTile({Key? key, required this.task, required this.taskController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: Colors.black,
        side: const BorderSide(
          color: Colors.black26,
        ),
        value: task.done,
        onChanged: (checkbox) {
          taskController.updateTask(task);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          color: task.done ? Colors.black26 : Colors.black,
          decoration:
              task.done ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        DateFormat('hh:mm a').format(task.dueTime),
        style: TextStyle(
          color: task.done ? Colors.black26 : Colors.grey,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          taskController.deleteTask(task);
        },
      ),
    );
  }
}
