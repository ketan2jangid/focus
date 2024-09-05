import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DurationSelectorWheel extends StatelessWidget {
  final double height;
  final double? magnification;
  final bool showBars;
  final double selectedItemHeight;
  final Function(int)? onChange;

  const DurationSelectorWheel({
    super.key,
    this.showBars = false,
    this.magnification,
    required this.height,
    required this.selectedItemHeight,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBars)
            Container(
              height: selectedItemHeight * 1.4,
              width: 140,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF1E1E1E),
                    width: 4,
                  ),
                  bottom: BorderSide(
                    color: Color(0xFF1E1E1E),
                    width: 4,
                  ),
                ),
              ),
            ),
          ListWheelScrollView.useDelegate(
            squeeze: 0.8,
            itemExtent: selectedItemHeight,
            physics: FixedExtentScrollPhysics(),
            useMagnifier: magnification != null,
            magnification: magnification ?? 1.0,
            diameterRatio: 5.0,
            overAndUnderCenterOpacity: 0.4,
            onSelectedItemChanged: onChange,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 12,
              builder: (context, index) {
                return Center(
                  child: Text(
                    ((index + 1) * 5).toString(),
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF1E1E1E),
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
