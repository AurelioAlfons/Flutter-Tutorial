import 'package:flutter/material.dart';
import 'package:flutter1/payroll/employee_list.dart';

class Payroll extends StatelessWidget {
  const Payroll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payroll System',
      initialRoute: '/',
      routes: {
        '/': (context) => const EmployeeList(),
        // '/add-employee': (context) => const AddEmployee(),
      },
    );
  }
}
