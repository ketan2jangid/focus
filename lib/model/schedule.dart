import 'package:hive/hive.dart';

import 'app_data.dart';

part 'schedule.g.dart';

@HiveType(typeId: 1)
class Schedule {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? duration;

  @HiveField(2)
  List<AppData>? apps;

  Schedule({this.name, this.duration, this.apps});

  Schedule.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    duration = json['duration'];
    if (json['apps'] != null) {
      apps = <AppData>[];
      json['apps'].forEach((v) {
        apps!.add(AppData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['duration'] = duration;
    if (apps != null) {
      data['apps'] = apps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
