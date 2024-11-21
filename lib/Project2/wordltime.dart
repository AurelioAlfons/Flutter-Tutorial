import 'package:flutter/material.dart';
import 'package:flutter1/Project2/pages/choose_location.dart';
import 'package:flutter1/Project2/pages/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class WorldTime extends StatefulWidget {
  const WorldTime({super.key});

  @override
  State<WorldTime> createState() => _WorldTime();
}

class _WorldTime extends State<WorldTime> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    const Home(),
    const Location(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text(
          'World Time',
          style: TextStyle(color: Colors.white),
        ),
      ),
      //
      body: pages[_currentIndex],
      //
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.location_city), label: 'Location')
      //   ],
      // ),
      //
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
          child: GNav(
              selectedIndex: _currentIndex,
              onTabChange: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              // Color
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: const Color.fromARGB(255, 61, 60, 60),
              // Size
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.location_on_outlined,
                  text: 'Location',
                )
              ]),
        ),
      ),
    );
  }
}
