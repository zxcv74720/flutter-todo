import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_front/modules/task/controller/task_controller.dart';

import '../../../data/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TaskController taskController;

  const TaskTile({Key? key, required this.task, required this.taskController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checkbox) {
            taskController.updateTask(task);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
            task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(task.dueTime),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            taskController.deleteTask(task);
          },
        ),
      ),
    );
  }
}