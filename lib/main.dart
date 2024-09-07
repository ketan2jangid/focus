import 'package:flutter/material.dart';
import 'package:focus/view/screens/schedule_apps_selector_screen.dart';
import 'package:focus/view/screens/home_tab.dart';
import 'package:focus/view/screens/permission_screen.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:focus/view/screens/schedule_completed_screen.dart';
import 'package:focus/view/screens/schedule_duration_screen.dart';
import 'package:focus/view/screens/schedule_ended_screen.dart';
import 'package:focus/view/screens/schedule_name_screen.dart';
import 'package:focus/view/screens/schedule_summary_screen.dart';

/// TODO: UPDATE README.md

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PermissionScreen(),
    );
  }
}
