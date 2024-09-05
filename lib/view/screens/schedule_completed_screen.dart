import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/buttons.dart';
import '../widgets/header.dart';
import 'home_screen.dart';

class ScheduleCompletedScreen extends StatelessWidget {
  const ScheduleCompletedScreen({super.key});

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
            Spacer(
              flex: 2,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "congratulations!",
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF444444),
                      fontSize: 24,
                    ),
                  ),
                  Gap(6),
                  Text(
                    "schedule complete",
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF999999),
                      fontSize: 16,
                    ),
                  ),
                  Gap(24),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 220,
                  )
                ],
              ),
            ),
            Spacer(
              flex: 3,
            ),
            SecondaryButton(
                onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                text: "home"),
          ],
        ),
      ),
    );
  }
}
