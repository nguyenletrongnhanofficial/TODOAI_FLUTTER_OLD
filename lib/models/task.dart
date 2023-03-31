class ListTask {
  final String title;
  final String date;
  final int color;
   bool isComplete;

   ListTask(
      {required this.date, required this.title, required this.color, this.isComplete = false});
}
