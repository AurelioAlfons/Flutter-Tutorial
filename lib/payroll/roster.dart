import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RosterScreen extends StatefulWidget {
  const RosterScreen({super.key});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  DateTime _currentWeekStart = _getMondayOfCurrentWeek();
  final Map<String, List<String>> _schedule = {}; // Employee schedules

  // Get Monday of the current week
  static DateTime _getMondayOfCurrentWeek() {
    final now = DateTime.now();
    return now.subtract(
        Duration(days: now.weekday - 1)); // Ensure Monday is the first day
  }

  // Get the week range
  String _getWeekRange() {
    final weekStart = _currentWeekStart;
    final weekEnd = weekStart.add(const Duration(days: 6));
    return '${DateFormat('d MMM').format(weekStart)} - ${DateFormat('d MMM').format(weekEnd)}';
  }

  // Generate days for the current week
  List<DateTime> _generateWeekDays() {
    return List.generate(
      7,
      (index) => _currentWeekStart.add(Duration(days: index)),
    );
  }

  // Navigate to the previous or next week
  void _changeWeek(int days) {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(Duration(days: days));
    });
  }

  // Add an employee or shift
  void _addShift(String day) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Employee Shift'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter employee name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _schedule[day] = _schedule[day] ?? [];
                  _schedule[day]!.add(nameController.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _generateWeekDays();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roster Scheduling'),
      ),
      body: Column(
        children: [
          // Week navigation with background color
          Container(
            color: const Color.fromARGB(255, 70, 50, 252),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _changeWeek(-7),
                  icon: const Icon(Icons.arrow_left, color: Colors.white),
                ),
                Text(
                  _getWeekRange(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => _changeWeek(7),
                  icon: const Icon(Icons.arrow_right, color: Colors.white),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Daily schedule with dividers and styled left section
          Expanded(
            child: ListView.builder(
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final day = weekDays[index];
                final formattedDay = DateFormat('EEEE d MMM').format(day);
                final shortDay = DateFormat('EEE').format(day).toUpperCase();
                final dayOfMonth = DateFormat('d').format(day);
                final employees = _schedule[formattedDay] ?? [];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: Day and date in a colored box
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 108, 67, 255),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  dayOfMonth,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                Text(
                                  shortDay,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Vertical divider between date and shifts
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          // Right: Employee shifts
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // Employee buttons
                                  ...employees.map(
                                    (employee) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      width: 120, // Same size as the add button
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle employee button click
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 68, 255, 199),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                4), // Square or rectangle
                                          ),
                                        ),
                                        child: Text(
                                          employee,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Add button
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 120, // Same size as employee buttons
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () => _addShift(formattedDay),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .transparent, // Transparent background
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4), // Square or rectangle
                                          side: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1), // Divider between days
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
