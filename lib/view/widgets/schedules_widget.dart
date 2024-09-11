import 'package:flutter/material.dart';
import 'package:focus/model/schedule.dart';
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
                        title: schedules[0].name!,
                        appsSelected: schedules[0].apps!.length,
                        cardColor: Color(0xFFEFEFDD),
                      ),
              ),
              Gap(8),
              Expanded(
                child: (schedules.length < 2)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        title: schedules[1].name!,
                        appsSelected: schedules[1].apps!.length,
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
                        title: schedules[2].name!,
                        appsSelected: schedules[2].apps!.length,
                        cardColor: Color(0xFFDDEDEF),
                      ),
              ),
              Gap(8),
              Expanded(
                child: (schedules.length < 4)
                    ? AddScheduleCard()
                    : ScheduleCard(
                        title: schedules[3].name!,
                        appsSelected: schedules[3].apps!.length,
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
