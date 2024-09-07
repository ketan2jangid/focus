import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:focus/view/widgets/navbar.dart';
import 'package:focus/view/widgets/schedule_cards.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0)
            .copyWith(top: MediaQuery.of(context).viewPadding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(36),
            Header(
              title: "good morning",
              subtitle: "get rid of chaos",
            ),
            Gap(16),

            // TODO: MOVE CARDS TO SINGLE WIDGET - SCHEDULECARDS
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ScheduleCard(
                      title: "work",
                      appsSelected: 4,
                      cardColor: Color(0xFFEFEFDD),
                    ),
                  ),
                  Gap(8),
                  Expanded(
                    child: AddScheduleCard(),
                  ),
                ],
              ),
            ),
            Gap(8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AddScheduleCard(),
                  ),
                  Gap(8),
                  Expanded(
                    child: AddScheduleCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
