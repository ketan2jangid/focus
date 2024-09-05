import 'package:flutter/material.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleSummaryScreen extends StatefulWidget {
  const ScheduleSummaryScreen({super.key});

  @override
  State<ScheduleSummaryScreen> createState() => _ScheduleSummaryScreenState();
}

class _ScheduleSummaryScreenState extends State<ScheduleSummaryScreen> {
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
            Icon(
              Icons.chevron_left_rounded,
              color: Color(0xFF1E1E1E),
              size: 32,
            ),
            Header(
              title: "work schedule",
              subtitle: "press start to begin",
            ),
            Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "apps",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF1E1E1E),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF1E1E1E),
                ),
              ],
            ),
            Divider(
              color: Color(0xFF999999),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ),
            ),
            Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "duration",
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF1E1E1E),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF1E1E1E),
                ),
              ],
            ),
            Divider(
              color: Color(0xFF999999),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                "30 mins",
                style: GoogleFonts.montserrat(
                  color: Color(0xFF1E1E1E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            // SecondaryButton(onTap: () {}, text: "indefinite"),
            // Gap(18),
            PrimaryButton(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleActiveScreen(),
                  ),
                  (route) => false,
                );
              },
              text: "start",
            ),
          ],
        ),
      ),
    );
  }
}
