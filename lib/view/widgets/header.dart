import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String title;
  final String? subtitle;

  const Header({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toLowerCase().split(" ")[0] +
              "\n" +
              title.toLowerCase().split(" ")[1],
          style: headerTitleStyle,
        ),
        if (subtitle != null) ...[
          Gap(12),
          Text(
            subtitle!,
            style: headerSubtitleStyle,
          )
        ]
      ],
    );
  }
}

final headerTitleStyle = GoogleFonts.montserrat(
  color: Color(0xFF1E1E1E),
  fontSize: 48,
  fontWeight: FontWeight.w500,
  height: 1.2,
);

final headerSubtitleStyle = GoogleFonts.montserrat(
  color: Color(0xFF999999),
  fontSize: 24,
);
