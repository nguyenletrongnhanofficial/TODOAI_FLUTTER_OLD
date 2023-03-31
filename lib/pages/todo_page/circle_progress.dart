import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleProgress extends StatefulWidget {
  const CircleProgress({super.key});

  @override
  State<CircleProgress> createState() => _CircleProgressState();
}

class _CircleProgressState extends State<CircleProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 70,
            color: Colors.transparent,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text('Đã hoàn thành'),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircularPercentIndicator(
                      radius: 28,
                      percent: 0.6,
                      progressColor: Color(0xFF00FF8A),
                      backgroundColor: Colors.lightGreen.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '60%',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF00FF8A),
                            ),
                          ),
                          Text(
                            'Ngày',
                            style: TextStyle(
                                fontSize: 8, color: Color(0xFF00FF8A)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircularPercentIndicator(
                      radius: 28,
                      percent: 0.5,
                      progressColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '50%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'Tuần',
                            style: TextStyle(
                                fontSize: 8, color: Colors.deepPurple),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircularPercentIndicator(
                      radius: 28,
                      percent: 0.4,
                      progressColor: Colors.red,
                      backgroundColor: Colors.red.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '40%',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            'Tháng',
                            style: TextStyle(fontSize: 8, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )),
              ],
            ),
          );
  }
}