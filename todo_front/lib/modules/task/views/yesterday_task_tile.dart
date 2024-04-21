import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_front/modules/task/controller/task_controller.dart';

import '../../../data/models/task.dart';

class YesterdayTaskTile extends StatelessWidget {
  final Task task;
  final TaskController taskController;

  const YesterdayTaskTile(
      {Key? key, required this.task, required this.taskController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Transform.translate(
        offset: const Offset(16, 0),
        child: Text(
          task.title,
          style: TextStyle(
            color: task.done ? Colors.black26 : Colors.black,
            decoration:
                task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
      subtitle: Transform.translate(
        offset: const Offset(16, 0),
        child: Text(
          DateFormat('hh:mm a').format(task.dueTime),
          style: TextStyle(
            color: task.done ? Colors.black26 : Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
      trailing: task.done
          ? null
          : IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                taskController.deleteTask(task);
              },
            ),
    );
  }
}
