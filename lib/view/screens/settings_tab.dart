import 'package:flutter/material.dart';
import 'package:focus/view/widgets/settings_tile.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/header.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

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
            SettingsTile(onTap: () {}, title: "about us"),
            SettingsTile(onTap: () {}, title: "contact us"),
            SettingsTile(onTap: () {}, title: "rate us"),
            SettingsTile(onTap: () {}, title: "privacy policy"),
          ],
        ),
      ),
    );
  }
}
