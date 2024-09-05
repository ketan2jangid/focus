import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        border: Border.all(
          color: Color(0xFFDDDDDD),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: _selectedIndex == 0
                        ? Color(0xFF1E1E1E)
                        : Color(0xFF444444),
                  ),
                  if (_selectedIndex == 0) ...[
                    Gap(12),
                    Text(
                      "Home",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF1E1E1E),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: _selectedIndex == 1
                        ? Color(0xFF1E1E1E)
                        : Color(0xFF444444),
                  ),
                  if (_selectedIndex == 1) ...[
                    Gap(12),
                    Text(
                      "Setting",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF1E1E1E),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
