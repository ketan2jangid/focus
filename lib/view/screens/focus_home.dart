import 'package:flutter/material.dart';
import 'package:focus/view/screens/home_tab.dart';
import 'package:focus/view/screens/settings_tab.dart';
import 'package:focus/view/widgets/navbar.dart';

class FocusHome extends StatefulWidget {
  const FocusHome({super.key});

  @override
  State<FocusHome> createState() => _FocusHomeState();
}

class _FocusHomeState extends State<FocusHome> {
  late final PageController _pageController;
  int activeTab = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Navbar(
            activeTab: activeTab,
            onPageChange: (page) {
              _pageController.animateToPage(page,
                  duration: Duration(milliseconds: 400), curve: Curves.linear);
              setState(() {});
            }),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            activeTab = page;
          });
        },
        children: [
          HomeTab(),
          SettingsTab(),
        ],
      ),
    );
  }
}
