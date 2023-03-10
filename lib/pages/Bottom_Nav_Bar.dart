import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:final_project/pages/settings.dart';
import 'package:flutter/material.dart';

import 'add_new_project_page.dart';
import 'developer_projects_page.dart';
import 'home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var currentIndex = 2;
  final pages = [DeveloperPage(), const AddNewProjectPage(), const HomePage()];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    /// Widget body;

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: const [
          Icon(Icons.person_outline, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.house_siding_rounded, size: 30, color: Colors.white),
        ],
        index: currentIndex,
        color: const Color(0xff0D1F38),
        buttonBackgroundColor: const Color(0xffB6C4D1),
        backgroundColor: Colors.white,
        onTap: (newindex) {
          setState(() {
            currentIndex = newindex;
          });
        },
        letIndexChange: (index) => true,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        height: 75.0,
      ),
    );
  }
}
