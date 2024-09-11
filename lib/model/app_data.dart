import 'package:hive/hive.dart';

part 'app_data.g.dart';

@HiveType(typeId: 0)
class AppData {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? package;

  @HiveField(2)
  String? icon;

  AppData({this.name, this.package, this.icon});

  AppData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    package = json['package'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['package'] = package;
    data['icon'] = icon;
    return data;
  }
}
