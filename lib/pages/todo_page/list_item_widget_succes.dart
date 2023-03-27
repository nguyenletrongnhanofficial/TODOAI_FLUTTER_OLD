import 'package:flutter/material.dart';
import 'package:todoai/models/task.dart';

class ItemSucces extends StatelessWidget {
   final ListTask task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

 const ItemSucces({
    super.key,
    required this.animation,
    required this.task,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: buildTaskSucces(),
      );

  Widget buildTaskSucces() => Container(
        height: 50,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 30,
              width: 4,             
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B1B1D).withOpacity(0.3),
                          decoration: TextDecoration.lineThrough
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      task.date,
                      style: TextStyle(fontSize: 10, 
                      color: const Color(0xFF1B1B1D).withOpacity(0.3), 
                      decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: 
                    onClicked                 
                  ,
                  icon: Image.asset('assets/icons/checkbox_icon.png')),
            )
          ],
        ),
      );
}
