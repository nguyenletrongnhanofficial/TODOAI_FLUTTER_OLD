class ListTask {
   String title;
   String date;
   int color;
   bool isComplete;

   ListTask(
      { required this.date, required this.title, required this.color, this.isComplete = false});
}
