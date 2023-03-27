import 'package:flutter/material.dart';

import 'package:todoai/models/task.dart';

class ListItemWidget extends StatelessWidget {
  final ListTask task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget({
    super.key,
    required this.animation,
    required this.task,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: buildTask(),
      );

  Widget buildTask() => Container(
        height: 50,
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 4,
              decoration: BoxDecoration(
                  color: Color(task.color),
                  borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      task.date,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
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
                  icon: Image.asset('assets/icons/Checkbox.png')),
            )
          ],
        ),
      );
}
