import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/duration_selector_wheel.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduleDurationScreen extends StatefulWidget {
  const ScheduleDurationScreen({super.key});

  @override
  State<ScheduleDurationScreen> createState() => _ScheduleDurationScreenState();
}

class _ScheduleDurationScreenState extends State<ScheduleDurationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(6),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF1E1E1E),
                size: 32,
              ),
            ),
            Header(
              title: "new schedule",
              subtitle: "select duration",
            ),
            Gap(36),
            Spacer(
              flex: 2,
            ),
            DurationSelectorWheel(
              showBars: true,
              magnification: 1.4,
              height: 240,
              selectedItemHeight: 60,
              onChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            Spacer(
              flex: 1,
            ),
            Center(
              child: Text(
                "minutes",
                style: GoogleFonts.montserrat(
                  color: Color(0xFF1E1E1E),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(
              flex: 5,
            ),
            PrimaryButton(
              onTap: () async {
                context.read<ScheduleController>().scheduleDuration =
                    (_currentIndex + 1) * 5;

                await context.read<ScheduleController>().saveSchedule();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleActiveScreen(
                        scheduleName:
                            context.read<ScheduleController>().scheduleName,
                        scheduleDuration: context
                                .read<ScheduleController>()
                                .scheduleDuration *
                            60,
                      ),
                    ),
                    (route) => false);
              },
              text: "start",
            ),
          ],
        ),
      ),
    );
  }
}
