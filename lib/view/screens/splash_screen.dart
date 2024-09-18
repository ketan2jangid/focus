import 'package:flutter/material.dart';
import 'package:focus/controller/native_functions_controller.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/view/screens/focus_home.dart';
import 'package:focus/view/screens/permission_screen.dart';
import 'package:focus/view/screens/schedule_active_screen.dart';
import 'package:provider/provider.dart';

// TODO: FORWARD TO SCREEN : PERMISSION, HOME, SCHEDULE ACTIVE
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/FOCUS.png",
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
