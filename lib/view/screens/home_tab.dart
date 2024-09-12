import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/model/schedule.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:focus/view/widgets/navbar.dart';
import 'package:focus/view/widgets/schedule_cards.dart';
import 'package:focus/view/widgets/schedules_widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
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

    // LOAD LIST OF INSTALLED APPS
    if (context.read<ScheduleController>().installedApps.isEmpty) {
      context.read<ScheduleController>().loadInstalledApps();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            if (_savedSchedules == null) ...[
              Spacer(),
              const LinearProgressIndicator(
                color: Color(0xFF1E1E1E),
              ),
              Spacer(),
            ],
            if (_savedSchedules != null) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: SchedulesWidget(
                    schedules: _savedSchedules!,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
