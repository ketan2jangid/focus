import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus/controller/native_functions_controller.dart';
import 'package:focus/view/screens/focus_home.dart';
import 'package:focus/view/screens/home_tab.dart';
import 'package:focus/view/widgets/buttons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/header.dart';

List<Widget> permissionPages = [
  Text(
    "we need ‘Display over other apps’ permission to work. This allows us to block you from using your device during focus mode",
    style: GoogleFonts.montserrat(
      color: Color(0xFF1E1E1E),
      fontSize: 16,
    ),
  ),
  Text(
    "we need accessibility permission to work. This allows us to detect when you use apps during focus mode",
    style: GoogleFonts.montserrat(
      color: Color(0xFF1E1E1E),
      fontSize: 16,
    ),
  ),
  // Text(
  //   "we need access to apps usage stats to work. This allows us to detect when you use apps during focus mode",
  //   style: GoogleFonts.montserrat(
  //     color: Color(0xFF1E1E1E),
  //     fontSize: 16,
  //   ),
  // ),
];

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  int _currentPage = 0;
  late final PageController _pageController;
  late Timer _timer;
  List<bool> permissionsStatus = [false, false];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(const Duration(milliseconds: 2500),
        (timer) => _checkPermissionsStatus());
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  Future<void> _checkPermissionsStatus() async {
    final perms = await Future.wait([
      NativeFunctionsController.instance.hasOverlayPermission(),
      // NativeFunctionsController.instance.hasUsageStatsPermission(),
      NativeFunctionsController.instance.hasAccessibilityPermission()
    ]);

    setState(() {
      permissionsStatus = perms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
          bottom: 24,
        ),
        child: permissionsStatus.isEmpty
            ? Center(
                child: LinearProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(36),
                  Header(
                    title: "grant permission",
                    subtitle: "grant permission to proceed",
                  ),
                  Gap(24),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: permissionPages.length,
                      itemBuilder: (context, index) {
                        return permissionPages[index];
                      },
                    ),
                  ),
                  PrimaryButton(
                    onTap: permissionsStatus[_currentPage]
                        ? () {
                            switch (_currentPage) {
                              case 0:
                                setState(() {
                                  _currentPage = 1;
                                });
                                _pageController.animateToPage(_currentPage,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease);
                                break;
                              case 1:
                                // setState(() {
                                //   _currentPage = 2;
                                // });
                                // _pageController.animateToPage(_currentPage,
                                //     duration: const Duration(milliseconds: 200),
                                //     curve: Curves.ease);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FocusHome(),
                                  ),
                                );
                                break;
                              default:
                                return;
                            }
                          }
                        : () async {
                            switch (_currentPage) {
                              case 0:
                                await NativeFunctionsController.instance
                                    .requestOverlayPermission();
                                break;
                              case 1:
                                await NativeFunctionsController.instance
                                    .requestAccessibilityPermission();
                                break;
                              default:
                                return;
                            }
                          },
                    text: permissionsStatus[_currentPage] == true
                        ? "next"
                        : "grant",
                  ),
                ],
              ),
      ),
    );
  }
}
