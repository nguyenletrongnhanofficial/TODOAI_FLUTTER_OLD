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

  Widget buildTask() =>task.isComplete? Container(
          height: 50,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
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
                      Text(task.title,
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        task.date,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: onClicked,
                    icon: Image.asset('assets/icons/checkbox_icon.png')),
              )
            ],
          ),
        )
      : Container(
          height: 50,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 3),
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        task.date,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: onClicked,
                    icon: Image.asset('assets/icons/Checkbox.png')),
              )
            ],
          ),
        );
}
