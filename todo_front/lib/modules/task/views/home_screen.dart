import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_front/modules/task/views/today_task_tile.dart';
import 'package:todo_front/modules/task/views/yesterday_task_tile.dart';

import '../../../data/models/task.dart';
import '../../../data/provider/task_provider.dart';
import '../controller/task_controller.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = Get.put(TaskController());
    _getTasks();
  }

  Future<void> _getTasks() async {
    final tasks = await TaskProvider.getTasks();
    _taskController.tasks.assignAll(tasks!);
  }

  Widget _buildTaskList(List<Task> tasks, Widget Function(Task) itemBuilder) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) => itemBuilder(tasks[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
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
            GetBuilder<TaskController>(
              builder: (controller) => _buildTaskList(controller.tasks, (task) => TodayTaskTile(task: task, taskController: controller)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            GetBuilder<TaskController>(
              builder: (controller) => _buildTaskList(controller.tasks, (task) => YesterdayTaskTile(task: task, taskController: controller)),
            ),
          ],
        ),
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
            builder: (context) => const AddTaskScreen(),
          );
        },
      ),
    );
  }
}
