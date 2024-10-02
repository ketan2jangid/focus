import 'package:flutter/material.dart';
import 'package:focus/controller/schedule_controller.dart';
import 'package:focus/view/screens/schedule_apps_selector_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:focus/view/widgets/header.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScheduleNameScreen extends StatefulWidget {
  const ScheduleNameScreen({super.key});

  @override
  State<ScheduleNameScreen> createState() => _ScheduleNameScreenState();
}

class _ScheduleNameScreenState extends State<ScheduleNameScreen> {
  late final TextEditingController _nameController;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _nameController.text = context.read<ScheduleController>().scheduleName;
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
            Form(
              key: _key,
              child: TextFormField(
                controller: _nameController,
                onChanged: (val) => setState(() {}),
                validator: (str) {
                  if (str != null && str.trim().contains(" ")) {
                    return "give a single word name to schedule";
                  }

                  return null;
                },
                keyboardType: TextInputType.name,
                cursorColor: Color(0xFF1E1E1E),
                style: GoogleFonts.montserrat(
                  color: Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "eg: study, work, meditation etc",
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red.shade800,
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
            ),
            Spacer(),
            PrimaryButton(
                disable: _nameController.text.isEmpty,
                onTap: () {
                  if (_key.currentState!.validate() == false) {
                    return;
                  }

                  context.read<ScheduleController>().scheduleName =
                      "${_nameController.text.trim()} schedule";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleAppsSelectorScreen(),
                    ),
                  );
                },
                text: "next"),
          ],
        ),
      ),
    );
  }
}
