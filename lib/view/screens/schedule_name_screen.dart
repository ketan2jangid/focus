import 'package:flutter/material.dart';
import 'package:focus/view/screens/schedule_apps_selector_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleNameScreen extends StatefulWidget {
  const ScheduleNameScreen({super.key});

  @override
  State<ScheduleNameScreen> createState() => _ScheduleNameScreenState();
}

class _ScheduleNameScreenState extends State<ScheduleNameScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
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
              subtitle: "name this schedule",
            ),
            Gap(36),
            TextField(
              controller: _nameController,
              onChanged: (val) => setState(() {}),
              cursorColor: Color(0xFF1E1E1E),
              decoration: InputDecoration(
                hintText: "eg: study schedule, work schedule etc",
                hintStyle: GoogleFonts.montserrat(
                  color: Color(0xFF999999),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF444444),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.shade800,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Spacer(),
            PrimaryButton(
                disable: _nameController.text.isEmpty,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleAppsSelectorScreen(),
                      ),
                    ),
                text: "next"),
          ],
        ),
      ),
    );
  }
}
