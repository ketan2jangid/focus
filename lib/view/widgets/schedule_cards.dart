import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focus/view/screens/schedule_name_screen.dart';
import 'package:focus/view/screens/schedule_summary_screen.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final int appsSelected;
  final Color cardColor;

  const ScheduleCard(
      {super.key,
      required this.title,
      required this.appsSelected,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleSummaryScreen(),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toLowerCase(),
              style: GoogleFonts.montserrat(
                color: Color(0xFF2E2E2E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),
            Text(
              "$appsSelected apps selected",
              style: GoogleFonts.montserrat(
                color: Color(0xFF444444),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddScheduleCard extends StatelessWidget {
  const AddScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleNameScreen(),
        ),
      ),
      child: DottedBorder(
        color: Color(0xFF999999),
        padding: EdgeInsets.zero,
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        strokeWidth: 1.4,
        dashPattern: [6, 6],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Color(0xFF999999),
                size: 48,
              ),
              Gap(12),
              Text(
                "Add Schedule",
                style: GoogleFonts.montserrat(
                  color: Color(0xFF999999),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
