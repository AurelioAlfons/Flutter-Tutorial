import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget {
  // Fixed "Class" to "class"
  const EmployeeList({super.key}); // Fixed incorrect constructor syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No employees added yet.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-employee');
              },
              child: const Text('Add Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
