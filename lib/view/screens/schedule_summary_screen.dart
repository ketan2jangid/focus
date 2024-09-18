import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/model/schedule.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduleSummaryScreen extends StatefulWidget {
  final Schedule scheduleData;
  const ScheduleSummaryScreen({super.key, required this.scheduleData});

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
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF1E1E1E),
                size: 32,
              ),
            ),
            Header(
              title: widget.scheduleData.name! + " schedule",
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
                  itemCount: widget.scheduleData.apps!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 36,
                      width: 36,
                      margin: EdgeInsets.only(right: 8),
                      // clipBehavior: Clip.antiAlias,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey,
                      //   borderRadius: BorderRadius.circular(4),
                      // ),
                      child: Image.memory(
                        Uint8List.fromList(
                            widget.scheduleData.apps![index].icon!.codeUnits),
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
                "${(widget.scheduleData.duration!)} mins",
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
              onTap: () async {
                await context.read<ScheduleController>().startSchedule(Schedule(
                    name: widget.scheduleData.name,
                    duration: widget.scheduleData.duration,
                    apps: widget.scheduleData.apps));

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleActiveScreen(
                      activeSchedule: context.read<ScheduleController>().currentSchedule!,
                    ),
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
