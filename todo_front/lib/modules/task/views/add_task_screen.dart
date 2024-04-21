import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = "";
  DateTime taskDueTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: ListView(
        children: [
          const Text(
            'Add a task',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  autofocus: true,
                  onChanged: (val) {
                    taskTitle = val;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your task',
                    hintStyle: TextStyle(color: Colors.black26),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Hour',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TimePickerSpinner(
                  is24HourMode: false,
                  alignment: Alignment.center,
                  itemHeight: 30,
                  highlightedTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  normalTextStyle: const TextStyle(fontSize: 15, color: Colors.black26),
                  onTimeChange: (time) {
                    setState(() {
                      taskDueTime = time;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                Get.find<TaskController>().addTask(taskTitle, taskDueTime);
                Get.back();
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              fixedSize: const Size.fromHeight(44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리를 10으로 설정
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
