import 'package:flutter/material.dart';
import 'package:flutter1/payroll/widget/add_employee_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final List<Map<String, String>> _employees = []; // Employee list

  @override
  void initState() {
    super.initState();
    _loadEmployees(); // Load saved employees
  }

  Future<void> _saveEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('employees', jsonEncode(_employees));
  }

  Future<void> _loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? employeesJson = prefs.getString('employees');
    if (employeesJson != null) {
      setState(() {
        _employees.addAll((jsonDecode(employeesJson) as List<dynamic>)
            .map((item) => (item as Map<String, dynamic>).map(
                  (key, value) => MapEntry(key, value as String),
                ))
            .toList());
      });
    }
  }

  void _showAddEmployeeDialog({Map<String, String>? employee, int? index}) {
    showDialog(
      context: context,
      builder: (context) => AddEmployeeDialog(
        initialName: employee?['name'],
        initialPosition: employee?['position'],
        initialSalary: employee?['salary'],
        onSave: (name, position, salary) {
          setState(() {
            if (index != null) {
              // Update existing employee
              _employees[index] = {
                'name': name,
                'position': position,
                'salary': salary,
              };
            } else {
              // Add new employee
              _employees.add({
                'name': name,
                'position': position,
                'salary': salary,
              });
            }
            _saveEmployees(); // Save updated employees
          });
        },
      ),
    );
  }

  void _deleteEmployee(int index) {
    setState(() {
      _employees.removeAt(index);
      _saveEmployees(); // Save after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: _employees.isEmpty
          ? const Center(
              child: Text(
                'No employees added yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final employee = _employees[index];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  leading: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 21, 231, 28), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded edges
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      '\$${employee['salary']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    employee['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Position: ${employee['position']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showAddEmployeeDialog(
                          employee: employee,
                          index: index,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEmployee(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEmployeeDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
