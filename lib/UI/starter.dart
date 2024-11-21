import 'package:flutter/material.dart';
import 'package:flutter1/UI/home.dart';
import 'package:flutter1/UI/profile.dart';
import 'package:flutter1/UI/save.dart';
import 'package:flutter1/UI/settings.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBro extends StatefulWidget {
  const NavigationBro({super.key});

  @override
  State<NavigationBro> createState() => _NavigationBroState();
}

class _NavigationBroState extends State<NavigationBro> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(), // Use a new widget for the actual Home content
    const SavePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex], // Show the selected page here
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            color: Colors.white,
            backgroundColor: Colors.black,
            gap: 8,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 61, 60, 60),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.save, text: 'Bookmark'),
              GButton(icon: Icons.person, text: 'Profile'),
              GButton(icon: Icons.settings, text: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
