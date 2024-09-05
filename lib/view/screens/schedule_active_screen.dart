import 'package:flutter/material.dart';
import 'package:focus/view/screens/schedule_completed_screen.dart';
import 'package:focus/view/screens/schedule_ended_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleActiveScreen extends StatefulWidget {
  const ScheduleActiveScreen({super.key});

  @override
  State<ScheduleActiveScreen> createState() => _ScheduleActiveScreenState();
}

class _ScheduleActiveScreenState extends State<ScheduleActiveScreen> {
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
            Gap(36),
            Header(title: "work schedule"),
            Spacer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: LinearProgressIndicator(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(4),
                        value: 0.3,
                      ),
                    ),
                  ),
                  Gap(24),
                  Text(
                    "10 min",
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SecondaryButton(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScheduleCompletedScreen(),
                ),
              ),
              text: "end now",
            ),
          ],
        ),
      ),
    );
  }
}
