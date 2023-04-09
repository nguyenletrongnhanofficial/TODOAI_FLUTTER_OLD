import 'package:flutter/material.dart';
import 'package:todoai/models/task.dart';

class ListItemWidget extends StatelessWidget {
  Task task;
  final VoidCallback? onClicked;
   ListItemWidget({
    super.key,
    required this.task,
    required this.onClicked
  });

color(int x){
  int  color = 0;
   switch(x){
    case 0: color = 0xFFFF0D0D;
    break;
    case 1: color = 0xFFF8EF15;
    break;
    case 2: color = 0xFF42F815;
    break;
    case 3: color = 0xFF15DDF8;
    break;
    case 4: color = 0xFFF815E2;
    break;
    case 5: color = 0xFFB015F8;
    break;
    case 6: color = 0xFF000000;
    break;
   }
   return color;
 }

  @override
  Widget build(BuildContext context) {

    return task.isComplete?

        Container(
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
                          onPressed:onClicked,
                          icon: Image.asset('assets/icons/checkbox_icon.png')),
                    )
                  ],
                ),
              )
        :Container(
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
                color: Color(color(task.color)),
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
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
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
}
