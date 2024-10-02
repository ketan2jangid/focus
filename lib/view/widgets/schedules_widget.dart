import 'package:flutter/material.dart';
import 'package:focus/model/schedule.dart';
import 'package:focus/view/screens/schedule_summary_screen.dart';
import 'package:gap/gap.dart';

import 'schedule_cards.dart';

class SchedulesWidget extends StatelessWidget {
  List<Schedule> schedules;

  SchedulesWidget({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: (schedules.isEmpty)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleSummaryScreen(
                                scheduleData: schedules[0],
                                scheduleIndex: 0,
                              ),
                            ),
                          );
                        },
                        scheduleData: schedules[0],
                        cardColor: Color(0xFFEFEFDD),
                      ),
              ),
              Gap(8),
              Expanded(
                child: (schedules.length < 2)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleSummaryScreen(
                                scheduleData: schedules[1],
                                scheduleIndex: 1,
                              ),
                            ),
                          );
                        },
                        scheduleData: schedules[1],
                        cardColor: Color(0xFFEADDEF),
                      ),
              ),
            ],
          ),
        ),
        Gap(8),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: (schedules.length < 3)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleSummaryScreen(
                                scheduleData: schedules[2],
                                scheduleIndex: 2,
                              ),
                            ),
                          );
                        },
                        scheduleData: schedules[2],
                        cardColor: Color(0xFFDDEDEF),
                      ),
              ),
              Gap(8),
              Expanded(
                child: (schedules.length < 4)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleSummaryScreen(
                                scheduleData: schedules[3],
                                scheduleIndex: 3,
                              ),
                            ),
                          );
                        },
                        scheduleData: schedules[3],
                        cardColor: Color(0xFFEFDDDD),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
