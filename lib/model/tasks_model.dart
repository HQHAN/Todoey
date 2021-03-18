import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/model/task.dart';

class TaskListModel extends ChangeNotifier {
  List<Task> _taskList = [
    Task(title: 'Buy milk', isDone: false),
    Task(title: 'Buy egg', isDone: false),
    Task(title: 'Buy bread', isDone: true),
  ];

  UnmodifiableListView<Task> get items => UnmodifiableListView(_taskList);

  int get totalTaskCount => _taskList.length;

  void add(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  void addByTitle(String title) {
    _taskList.add(
      Task(title: title, isDone: false),
    );
    notifyListeners();
  }

  void remove(Task task) {
    _taskList.remove(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void clear() {
    _taskList.clear();
    notifyListeners();
  }
}
