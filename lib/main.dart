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
import 'package:focus/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/native_functions_controller.dart';

/// TODO: UPDATE README.md

void main() async {
  await LocalDatabase.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> _getInitialScreen() async {
    final perms = await Future.wait([
      NativeFunctionsController.instance.hasOverlayPermission(),
      NativeFunctionsController.instance.hasAccessibilityPermission()
    ]);

    if ((perms[0] && perms[1]) == false) {
      return PermissionScreen();
    }

    final activeSchedule = LocalDatabase.activeSchedule;
    // final currentTime = DateTime.now().millisecondsSinceEpoch;

    // TODO: CHECK IF ACTIVE SCHEDULE TIME IS COMPLETE
    if (activeSchedule == null) {
      return FocusHome();
    }

    return ScheduleActiveScreen(activeSchedule: activeSchedule);
  }

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
        home: FutureBuilder(
          future: _getInitialScreen(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            }

            return SplashScreen();
          },
        ),
      ),
    );
  }
}
