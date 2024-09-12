import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/view/screens/focus_home.dart';
import 'package:focus/view/screens/schedule_apps_selector_screen.dart';
import 'package:focus/view/screens/home_tab.dart';
import 'package:focus/view/screens/permission_screen.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:focus/view/screens/schedule_completed_screen.dart';
import 'package:focus/view/screens/schedule_duration_screen.dart';
import 'package:focus/view/screens/schedule_ended_screen.dart';
import 'package:focus/view/screens/schedule_name_screen.dart';
import 'package:focus/view/screens/schedule_summary_screen.dart';
import 'package:provider/provider.dart';

/// TODO: UPDATE README.md

void main() async {
  await LocalDatabase.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScheduleController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Focus',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        // TODO: ADD ON GENERATE ROUTE, AND LOAD INITIAL SCREEN
        home: const FocusHome(),
      ),
    );
  }
}
