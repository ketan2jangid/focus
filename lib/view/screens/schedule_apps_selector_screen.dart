import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/model/app_data.dart';
import 'package:focus/view/screens/schedule_duration_screen.dart';
import 'package:gap/gap.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons.dart';
import '../widgets/header.dart';

class ScheduleAppsSelectorScreen extends StatefulWidget {
  const ScheduleAppsSelectorScreen({super.key});

  @override
  State<ScheduleAppsSelectorScreen> createState() =>
      _ScheduleAppsSelectorScreenState();
}

class _ScheduleAppsSelectorScreenState
    extends State<ScheduleAppsSelectorScreen> {
  bool isLoading = false;
  List<int> selectedApps = [];
  List<AppInfo> appsList = [];

  @override
  void initState() {
    super.initState();

    getInstalledApps();
  }

  Future<void> getInstalledApps() async {
    try {
      setState(() {
        isLoading = true;
      });

      appsList = await InstalledApps.getInstalledApps(true, true);

      setState(() {
        isLoading = false;
      });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
          bottom: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(6),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF1E1E1E),
                size: 32,
              ),
            ),
            Header(
              title: "new schedule",
              subtitle: "select apps to block",
            ),
            Gap(36),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF999999),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: LinearProgressIndicator(
                          color: Color(0xFF1E1E1E),
                        ),
                      )
                    : GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 6.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: appsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (selectedApps.contains(index)) {
                                selectedApps.remove(index);
                              } else {
                                selectedApps.add(index);
                              }

                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: Image.memory(
                                        appsList[index].icon!,
                                        height: 42,
                                        width: 42,
                                      ),
                                    ),
                                    if (selectedApps.contains(index))
                                      Container(
                                        height: 42,
                                        width: 42,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                      )
                                  ],
                                ),
                                Gap(6),
                                Text(
                                  appsList[index].name,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            Gap(24),
            PrimaryButton(
              disable: selectedApps.isEmpty,
              onTap: () {
                List<AppData> apps = [];

                selectedApps.forEach((ind) {
                  apps.add(AppData.fromJson({
                    "name": appsList[ind].name,
                    "package": appsList[ind].packageName,
                    "icon": String.fromCharCodes(appsList[ind].icon!)
                  }));
                });

                context.read<ScheduleController>().scheduleApps = apps;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleDurationScreen(),
                  ),
                );
              },
              text: "next",
            ),
          ],
        ),
      ),
    );
  }
}
