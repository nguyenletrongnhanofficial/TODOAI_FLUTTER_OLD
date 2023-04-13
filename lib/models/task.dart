class Task {
  final String id;
  final String title;
  final String date;
  final String describe;
  final String time;
  final int color;

  bool isComplete;

  Task(
      {required this.id,
      required this.date,
      required this.title,
      required this.isComplete,
      required this.describe,
      required this.time,
      required this.color});

  static toTask(Map<String, dynamic> data) {
    return Task(
      id: data["_id"] ?? "",
      date: data["date"] ?? "",
      title: data["title"] ?? "",
      isComplete: data["isComplete"] ?? "",
      describe: data["describe"] ?? "",
      time: data["time"] ?? "",
      color: data["color"] ?? "",
    );
  }
}
