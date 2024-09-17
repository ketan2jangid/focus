import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/model/schedule.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import 'native_functions_controller.dart';

class ScheduleController extends ChangeNotifier {
  Schedule? _activeSchedule;
  String _scheduleName = "";
  List<AppData> _selectedApps = [];
  int _duration = 0;
  List<AppInfo> _installedApps = [];

  String get scheduleName => _scheduleName;
  List<AppData> get scheduleApps => _selectedApps;
  int get scheduleDuration => _duration;
  Schedule? get currentSchedule => _activeSchedule;
  List<AppInfo> get installedApps => _installedApps;

  set scheduleName(String name) {
    _scheduleName = name;

    notifyListeners();
  }

  set scheduleApps(List<AppData> apps) {
    _selectedApps = apps;

    notifyListeners();
  }

  set scheduleDuration(int duration) {
    _duration = duration;

    notifyListeners();
  }

  Future<void> saveSchedule() async {
    final newSchedule = Schedule(
        name: scheduleName, duration: scheduleDuration, apps: scheduleApps);

    final success = await LocalDatabase.saveSchedule(newSchedule);
    log(success.toString());

    startSchedule(newSchedule);
  }

  Future<void> startSchedule(Schedule schedule) async {
    _activeSchedule = schedule;

    List<String> packages = [];
    for (AppData app in schedule.apps!) {
      packages.add(app.package!);
    }

    await LocalDatabase.startSchedule(schedule);

    await NativeFunctionsController.instance.startSchedule({
      "name": schedule.name!,
      "startTime": DateTime.now().millisecondsSinceEpoch.truncate(),
      "endTime": DateTime.now().millisecondsSinceEpoch.truncate() +
          (60000 * schedule.duration!),
      "blockedApps": packages
    });

    log("schedule started");

    notifyListeners();
  }

  Future<void> endSchedule() async {
    _activeSchedule = null;

    await LocalDatabase.endSchedule();

    await NativeFunctionsController.instance.endSchedule();

    log("schedule ended");

    notifyListeners();
  }

  Future<void> loadInstalledApps() async {
    _installedApps = await InstalledApps.getInstalledApps(true, true);

    notifyListeners();
  }
}
