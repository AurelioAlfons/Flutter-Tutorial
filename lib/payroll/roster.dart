import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class RosterScreen extends StatefulWidget {
  final List<Map<String, String>> employees;

  const RosterScreen({super.key, required this.employees});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  DateTime _currentWeekStart = _getMondayOfCurrentWeek();
  final Map<String, List<Map<String, String>>> _schedule = {};
  late List<Map<String, String>> _employees;

  @override
  void initState() {
    super.initState();
    _employees = List.from(widget.employees);
    _loadEmployees();
    _loadShifts(); // Load saved shifts when initializing
  }

  Future<void> _loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? employeesJson = prefs.getString('employees');

    if (employeesJson != null) {
      final loadedEmployees = (jsonDecode(employeesJson) as List<dynamic>)
          .map((item) => (item as Map<String, dynamic>).map(
                (key, value) => MapEntry(key, value as String),
              ))
          .toList();

      setState(() {
        _employees = loadedEmployees;
      });
    }
  }

  Future<void> _saveShifts() async {
    final prefs = await SharedPreferences.getInstance();
    final shiftsJson = jsonEncode(_schedule);
    await prefs.setString('shifts', shiftsJson);
  }

  Future<void> _loadShifts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? shiftsJson = prefs.getString('shifts');
    if (shiftsJson != null) {
      setState(() {
        _schedule.clear();
        final loadedShifts = jsonDecode(shiftsJson) as Map<String, dynamic>;
        loadedShifts.forEach((day, shifts) {
          _schedule[day] = (shifts as List<dynamic>).map((shift) {
            return (shift as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value.toString()),
            );
          }).toList();
        });
      });
    }
  }

  static DateTime _getMondayOfCurrentWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  String _getWeekRange() {
    final weekStart = _currentWeekStart;
    final weekEnd = weekStart.add(const Duration(days: 6));
    return '${DateFormat('d MMM').format(weekStart)} - ${DateFormat('d MMM').format(weekEnd)}';
  }

  List<DateTime> _generateWeekDays() {
    return List.generate(
      7,
      (index) => _currentWeekStart.add(Duration(days: index)),
    );
  }

  void _changeWeek(int days) {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(Duration(days: days));
    });
  }

  void _addOrEditShift(String day, {Map<String, String>? existingShift}) {
    String? selectedEmployee = existingShift?['employee'];
    TimeOfDay? startTime =
        existingShift != null ? _parseTimeOfDay(existingShift['start']!) : null;
    TimeOfDay? endTime =
        existingShift != null ? _parseTimeOfDay(existingShift['end']!) : null;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add/Edit Employee Shift',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Select Employee Dropdown
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Employee',
                      ),
                      value: selectedEmployee,
                      items: _employees
                          .map((employee) => DropdownMenuItem<String>(
                                value: employee['name'],
                                child: Text(employee['name']!),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedEmployee = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Start Time and End Time Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Start Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              DropdownButtonFormField<TimeOfDay>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                value: startTime,
                                items: List.generate(
                                  24,
                                  (index) => TimeOfDay(
                                    hour: index,
                                    minute: 0,
                                  ),
                                ).map((time) {
                                  return DropdownMenuItem<TimeOfDay>(
                                    value: time,
                                    child: Text(time.format(context)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    startTime = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'End Time',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              DropdownButtonFormField<TimeOfDay>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                value: endTime,
                                items: List.generate(
                                  24,
                                  (index) => TimeOfDay(
                                    hour: index,
                                    minute: 0,
                                  ),
                                ).map((time) {
                                  return DropdownMenuItem<TimeOfDay>(
                                    value: time,
                                    child: Text(time.format(context)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    endTime = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedEmployee != null &&
                                startTime != null &&
                                endTime != null &&
                                (endTime!.hour > startTime!.hour ||
                                    (endTime!.hour == startTime!.hour &&
                                        endTime!.minute > startTime!.minute))) {
                              final workHours = endTime!.hour -
                                  startTime!.hour +
                                  (endTime!.minute - startTime!.minute) / 60.0;

                              final selectedEmpData = _employees.firstWhere(
                                  (emp) => emp['name'] == selectedEmployee);

                              final hourlyRate =
                                  double.tryParse(selectedEmpData['salary']!) ??
                                      0;
                              final salaryEarned =
                                  (hourlyRate * workHours).toStringAsFixed(2);

                              setState(() {
                                _schedule[day] = _schedule[day] ?? [];
                                if (existingShift != null) {
                                  _schedule[day]!.remove(existingShift);
                                }
                                _schedule[day]!.add({
                                  'employee': selectedEmployee!,
                                  'hours': workHours.toStringAsFixed(1),
                                  'start': startTime!.format(context),
                                  'end': endTime!.format(context),
                                  'salary': salaryEarned,
                                });
                              });
                              _saveShifts();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please select valid times and an employee.'),
                                ),
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  TimeOfDay _parseTimeOfDay(String time) {
    try {
      if (time.contains("AM") || time.contains("PM")) {
        final format = DateFormat.jm();
        final dateTime = format.parse(time);
        return TimeOfDay.fromDateTime(dateTime);
      } else {
        final parts = time.split(":");
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error parsing time: $time - $e");
      return const TimeOfDay(hour: 0, minute: 0);
    }
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
          Container(
            color: Colors.blueAccent,
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
          Expanded(
            child: ListView.builder(
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final day = weekDays[index];
                final formattedDay = DateFormat('EEEE d MMM').format(day);
                final shifts = _schedule[formattedDay] ?? [];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('d').format(day),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('EEE').format(day).toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...shifts.map(
                                    (shift) => GestureDetector(
                                      onTap: () => _addOrEditShift(
                                        formattedDay,
                                        existingShift: shift,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        width: 200,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 61, 235, 127),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${shift['start']} - ${shift['end']}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${shift['hours']} hrs',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  shift['employee']!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '\$${shift['salary']}',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: 120,
                                    height: 70,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _addOrEditShift(formattedDay),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                    const Divider(height: 1),
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
