import 'package:flutter/material.dart';
import 'package:flutter1/payroll/employee_list.dart';
import 'package:flutter1/payroll/roster.dart';

class Payroll extends StatelessWidget {
  const Payroll({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payroll System',
      home: MainScreen(), // Main screen manages bottom navigation
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // To track the selected tab

  // Define the pages for each bottom navigation bar item
  static const List<Widget> _pages = <Widget>[
    EmployeeList(), // Employee List Screen
    RosterScreen(
      employees: [],
    ), // Roster Scheduling Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlight the selected tab
        onTap: _onItemTapped, // Handle tab selection
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Roster',
          ),
        ],
      ),
    );
  }
}
