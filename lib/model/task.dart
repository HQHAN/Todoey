class Task {
  String title;
  bool isDone = false;

  Task({this.title, this.isDone});

  void toggleDone() {
    isDone = !isDone;
  }
}
