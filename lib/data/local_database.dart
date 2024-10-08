import 'dart:developer';

import 'package:focus/data/storage_keys.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/model/schedule.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  static Box? _savedSchedules;

  static List<Schedule> get savedSchedules =>
      (_savedSchedules!.get(StorageKeys.schedulesList))?.cast<Schedule>() ?? [];
  static Schedule? get activeSchedule =>
      (_savedSchedules!.get(StorageKeys.activeSchedule));
  static int get startTime =>
      _savedSchedules!.get(StorageKeys.scheduleStartTime) ?? 0;
  static int get endTime =>
      _savedSchedules!.get(StorageKeys.scheduleEndTime) ?? 0;
  static bool get blockNotificationsPreference =>
      _savedSchedules!.get(StorageKeys.blockNotifications) ?? false;

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

  static Future<void> updateSchedule(Schedule schedule, int index) async {
    try {
      List<Schedule> schedules = savedSchedules;

      schedules[index] = schedule;

      await _savedSchedules!.put(StorageKeys.schedulesList, schedules);

      log(schedules.length.toString());
    } catch (err) {
      print("ERR: something went wrong");
    }
  }

  static Future<void> startSchedule(
      Schedule schedule, int startTime, int endTime) async {
    await _savedSchedules!.put(StorageKeys.activeSchedule, schedule);
    await _savedSchedules!.put(StorageKeys.scheduleStartTime, startTime);
    await _savedSchedules!.put(StorageKeys.scheduleEndTime, endTime);
  }

  static Future<void> endSchedule() async {
    await _savedSchedules!.delete(StorageKeys.activeSchedule);
    await _savedSchedules!.delete(StorageKeys.scheduleStartTime);
    await _savedSchedules!.delete(StorageKeys.scheduleEndTime);
  }

  static Future<void> deleteSchedule(int index) async {
    final schedulesList = savedSchedules;
    schedulesList.removeAt(index);

    await _savedSchedules!.put(StorageKeys.schedulesList, schedulesList);
  }

  static Future<void> updateNotificationsBlockingPreference() async {
    await _savedSchedules!.put(StorageKeys.blockNotifications, !blockNotificationsPreference);
  }

  static Future<void> clearData() async {}
}
