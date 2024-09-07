import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatefulWidget {
  int activeTab;
  final onPageChange;
  Navbar({super.key, required this.activeTab, required this.onPageChange});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      // margin: EdgeInsets.symmetric(vertical: 24),
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
                widget.onPageChange(0);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: widget.activeTab == 0
                        ? Color(0xFF1E1E1E)
                        : Color(0xFF444444),
                  ),
                  if (widget.activeTab == 0) ...[
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
                widget.onPageChange(1);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: widget.activeTab == 1
                        ? Color(0xFF1E1E1E)
                        : Color(0xFF444444),
                  ),
                  if (widget.activeTab == 1) ...[
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
