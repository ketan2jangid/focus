import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const SettingsTile({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: GoogleFonts.montserrat(color: Color(0xFF444444), fontSize: 24),
        ),
      ),
    );
  }
}
