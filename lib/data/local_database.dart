import 'dart:developer';

import 'package:focus/data/storage_keys.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/model/schedule.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  static Box? _savedSchedules;

  static List<Schedule> get savedSchedules =>
      (_savedSchedules!.get(StorageKeys.schedulesList))?.cast<Schedule>() ?? [];

  static Future<void> initialize() async {
    await Hive.initFlutter();

    // ************   REGISTER ADAPTERS *************
    Hive.registerAdapter(AppDataAdapter());
    Hive.registerAdapter(ScheduleAdapter());

    // ************  OPEN BOXES  ****************
    _savedSchedules = await Hive.openBox(StorageKeys.schedulesBox);
  }

  static Future<bool> saveSchedule(Schedule schedule) async {
    try {
      List<Schedule> schedules = savedSchedules;

      if (savedSchedules.length < 4) {
        schedules.add(schedule);

        await _savedSchedules!.put(StorageKeys.schedulesList, schedules);

        log(schedules.length.toString());

        return true;
      } else {
        return false;
      }
    } catch (err) {
      print("ERR: something went wrong");

      return false;
    }
  }

  static Future<void> clearData() async {}
}
