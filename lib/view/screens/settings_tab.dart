import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:focus/controller/native_functions_controller.dart';
import 'package:focus/data/local_database.dart';
import 'package:focus/view/widgets/settings_tile.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/header.dart';

// TODO: ADD BATTERY OPTIMIZATION, AUTO START OPTIONS, NOTIFICATIONS ACCESS
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0)
            .copyWith(top: MediaQuery.of(context).viewPadding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(36),
            Header(
              title: "focus settings",
            ),
            Gap(24),
            InkWell(
              onTap: () async {
                final perm = await NativeFunctionsController.instance
                    .hasNotificationsAccess();

                if (!perm) {
                  await NativeFunctionsController.instance
                      .requestNotificationsAccess();
                } else {
                  await LocalDatabase.updateNotificationsBlockingPreference();

                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Also block notifications",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF444444),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      LocalDatabase.blockNotificationsPreference
                          ? "Enabled"
                          : "Disabled",
                      style: GoogleFonts.montserrat(
                          color: LocalDatabase.blockNotificationsPreference
                              ? Color(0xFF444444)
                              : Colors.red,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            // SettingsTile(
            //     onTap: () async {
            //       // final perm = await NativeFunctionsController.instance
            //       //     .isBatteryOptimizationDisabled();
            //       // log(perm.toString());
            //     },
            //     title: "about us"),
            // SettingsTile(
            //     onTap: () async {
            //       // await NativeFunctionsController.instance
            //       //     .openBatteryOptimizationSettings();
            //     },
            //     title: "contact us"),
            // SettingsTile(onTap: () {}, title: "rate us"),
            // SettingsTile(onTap: () {}, title: "privacy policy"),
          ],
        ),
      ),
    );
  }
}
