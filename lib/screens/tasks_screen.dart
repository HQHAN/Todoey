import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task.dart';
import 'package:todo/model/tasks_model.dart';
import 'package:todo/screens/add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      child: AddTaskScreen(),
                    ),
                  );
                });
          },
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.add,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'ToDoye',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '${context.watch<TaskListModel>().totalTaskCount} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Consumer<TaskListModel>(
                      builder: (context, taskList, child) {
                    final List<Task> list = taskList.items;
                    return ListView.separated(
                      itemCount: taskList.totalTaskCount,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskListTile(
                          task: list[index],
                          onCheckedChanged: (newValue) {
                            taskList.toggleTask(list[index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    );
                  }),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListTile extends StatelessWidget {
  TaskListTile({this.task, this.onCheckedChanged});

  final Task task;
  final Function onCheckedChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        Provider.of<TaskListModel>(context, listen: false).remove(task);
      },
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: onCheckedChanged,
      ),
    );
  }
}
