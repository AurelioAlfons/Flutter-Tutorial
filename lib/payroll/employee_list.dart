import 'package:flutter/material.dart';
import 'package:flutter1/payroll/widget/add_employee_dialog.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final List<Map<String, String>> _employees = [];

  void _showAddEmployeeDialog({Map<String, String>? employee, int? index}) {
    showDialog(
      context: context,
      builder: (context) => AddEmployeeDialog(
        initialName: employee?['name'],
        initialPosition: employee?['position'],
        initialSalary: employee?['salary'],
        onSave: (String name, String position, String salary) {
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
          });
        },
      ),
    );
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
          : ListView.separated(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final employee = _employees[index];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name and position
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              employee['position']!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      // Salary as a button
                      ElevatedButton(
                        onPressed: () {
                          // Optional action for the salary button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 231, 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        child: Text(
                          '\$${employee['salary']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Open the dialog to edit employee details
                    _showAddEmployeeDialog(employee: employee, index: index);
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEmployeeDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: EmployeeList(),
    debugShowCheckedModeBanner: false,
  ));
}
