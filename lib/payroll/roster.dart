import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class RosterScreen extends StatefulWidget {
  final List<Map<String, String>> employees; // Employee list from EmployeeList

  const RosterScreen({super.key, required this.employees});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  DateTime _currentWeekStart = _getMondayOfCurrentWeek();
  final Map<String, List<String>> _schedule = {}; // Employee schedules
  late List<Map<String, String>> _employees; // Local employee list

  @override
  void initState() {
    super.initState();
    _employees = List.from(widget.employees); // Initialize local employees list
    _loadEmployees(); // Load additional employees from SharedPreferences
  }

  // Load Employees from SharedPreferences
  Future<void> _loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? employeesJson = prefs.getString('employees');

    if (employeesJson != null) {
      setState(() {
        _employees = (jsonDecode(employeesJson) as List<dynamic>)
            .map((item) => (item as Map<String, dynamic>).map(
                  (key, value) => MapEntry(key, value as String),
                ))
            .toList();
      });
    }
  }

  // Get Monday of the current week
  static DateTime _getMondayOfCurrentWeek() {
    final now = DateTime.now();
    return now
        .subtract(Duration(days: now.weekday - 1)); // Start week on Monday
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

  // Add a shift for selected employee
  void _addShift(String day) {
    String? selectedEmployee;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Employee Shift'),
          content: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select Employee',
            ),
            value: selectedEmployee,
            items: _employees
                .map((employee) => DropdownMenuItem<String>(
                      value: employee['name'], // Use employee name as value
                      child: Text(employee['name']!),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedEmployee = value!;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedEmployee != null) {
                  setState(() {
                    _schedule[day] = _schedule[day] ?? [];
                    _schedule[day]!.add(selectedEmployee!);
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select an employee.')),
                  );
                }
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
        title: Text('Roster Scheduling (${_getWeekRange()})'),
      ),
      body: Column(
        children: [
          // Week navigation
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

          // Daily schedule
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
                          // Day and date
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
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  shortDay,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Vertical divider
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          // Employee shifts
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...employees.map(
                                    (employee) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      width: 120,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle employee button click
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 68, 255, 199),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                  // Add shift button
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 120,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () => _addShift(formattedDay),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
