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
    return tasks == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Obx(() => Text(
                    'Todo Tasks (${Get.find<TaskController>().tasks.length})',
                  )),
              centerTitle: true,
              backgroundColor: Colors.green,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTaskScreen();
                    });
              },
            ),
          );
  }
}
