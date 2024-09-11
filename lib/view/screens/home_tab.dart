import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/model/schedule.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:focus/view/widgets/navbar.dart';
import 'package:focus/view/widgets/schedule_cards.dart';
import 'package:focus/view/widgets/schedules_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Schedule>? _savedSchedules;

  @override
  void initState() {
    super.initState();

    _getSchedules();
  }

  Future<void> _getSchedules() async {
    setState(() {
      _savedSchedules = LocalDatabase.savedSchedules;
    });

    print(_savedSchedules);
  }

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
            if (_savedSchedules == null) const LinearProgressIndicator(),
            if (_savedSchedules != null) ...[
              Expanded(
                child: SchedulesWidget(
                  schedules: _savedSchedules!,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
