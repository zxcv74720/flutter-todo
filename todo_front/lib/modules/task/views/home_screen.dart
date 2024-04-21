import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_front/data/provider/task_provider.dart';
import 'package:todo_front/modules/task/controller/task_controller.dart';
import 'package:todo_front/modules/task/views/task_tile.dart';

import '../../../data/models/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

  getTasks() async {
    tasks = await TaskProvider.getTasks();
    Get.find<TaskController>().tasks.assignAll(tasks!);
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              onPressed: () => print("logout action"),
              icon: const Icon(
                Icons.account_circle,
                size: 44,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<TaskController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    Task task = controller.tasks[index];
                    return TaskTile(
                      task: task,
                      taskController: controller,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              builder: (context) {
                return const AddTaskScreen();
              });
        },
      ),
    );
  }
}
