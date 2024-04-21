import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.green,
            ),
          ),
          TextField(
            autofocus: true,
            onChanged: (val) {
              taskTitle = val;
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                Get.find<TaskController>().addTask(taskTitle);
                Get.back();
              }
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}