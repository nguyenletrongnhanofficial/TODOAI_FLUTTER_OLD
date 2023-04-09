class Task {
  final String id;
  final String title;
  final String date;
  final String describe;
  final int color;

  bool isComplete;

  Task(
      {required this.id,
      required this.date,
      required this.title,
      required this.isComplete,
      required this.describe,
      required this.color});

  static toTask(Map<String, dynamic> data) {
    return Task(
      id: data["_id"] ?? "",
      date: data["date"] ?? "",
      title: data["title"] ?? "",
      isComplete: data["isComplete"] ?? "",
      describe: data["describe"] ?? "",
      color: data["color"]??"",
    );
  }
}
