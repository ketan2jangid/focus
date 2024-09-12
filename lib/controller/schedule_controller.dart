import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/model/schedule.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

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

  void startSchedule(Schedule schedule) {
    _activeSchedule = schedule;

    log("schedule started");

    notifyListeners();
  }

  void endSchedule() {
    _activeSchedule = null;

    log("schedule ended");

    notifyListeners();
  }

  Future<void> loadInstalledApps() async {
    _installedApps = await InstalledApps.getInstalledApps(true, true);

    notifyListeners();
  }
}
