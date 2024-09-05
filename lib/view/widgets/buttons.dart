import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  bool disable;
  final String text;
  final Function()? onTap;

  PrimaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.disable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disable ? null : onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color:
              disable ? Color(0xFF1E1E1E).withOpacity(0.5) : Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text.toLowerCase(),
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const SecondaryButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF999999),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text.toLowerCase(),
          style: GoogleFonts.montserrat(
            color: Color(0xFF444444),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
