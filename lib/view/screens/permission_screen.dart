import 'package:flutter/material.dart';
import 'package:focus/view/screens/home_screen.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/header.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

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
            Gap(36),
            Header(
              title: "grant permission",
              subtitle: "grant permission to proceed",
            ),
            Gap(24),
            Text(
              "we need access to apps usage sta to work. This allows us to detect when you use apps during focus mode",
              style: GoogleFonts.montserrat(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
              ),
            ),
            Spacer(),
            PrimaryButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              text: "grant",
            ),
          ],
        ),
      ),
    );
  }
}
