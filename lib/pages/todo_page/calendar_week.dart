import 'package:flutter/material.dart';
import 'dart:core';

class CalendarWeek extends StatelessWidget {
  const CalendarWeek({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekdays = List<DateTime>.generate(
        7,
        (int index) => DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1))
            .add(Duration(days: index)));
    List<int> dayList = weekdays.map((date) => date.day).toList();
    
    return SizedBox(
            height: 80,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(         
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75  ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 2'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[0].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),                  
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 3'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[1].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 4'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[2].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 5'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[3].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                   padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 6'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[4].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Thứ 7'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[5].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Container(
                      width: 60,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('CN'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dayList[6].toString(),
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}