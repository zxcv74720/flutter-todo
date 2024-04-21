class Task {
  final int id;
  final String title;
  final DateTime dueTime;
  bool done;

  Task({
    required this.id,
    required this.title,
    required this.dueTime,
    this.done = false,
  });

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      dueTime: DateTime.parse(taskMap['dueTime']),
      done: taskMap['done'],
    );
  }

  void toggle() {
    done = !done;
  }
}
