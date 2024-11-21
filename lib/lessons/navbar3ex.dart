import 'package:flutter/material.dart';
import 'package:flutter1/UI/home.dart';
import 'package:flutter1/UI/profile.dart';
import 'package:flutter1/UI/save.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleNav extends StatefulWidget {
  const GoogleNav({super.key});

  @override
  State<GoogleNav> createState() => _GoogleNavState();
}

class _GoogleNavState extends State<GoogleNav> {
  int _currentIndex = 0;

  List<Widget> pages = const [HomePage(), SavePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GNav(
              backgroundColor: Colors.amber,
              tabBackgroundColor: Colors.green,
              gap: 7,
              selectedIndex: _currentIndex,
              onTabChange: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.width_normal_outlined,
                  text: 'Walah',
                ),
                GButton(
                  icon: Icons.format_textdirection_r_to_l_sharp,
                  text: 'Hohoh',
                ),
                GButton(
                  icon: Icons.kayaking,
                  text: 'Oman',
                )
              ]),
        ),
      ),
    );
  }
}
