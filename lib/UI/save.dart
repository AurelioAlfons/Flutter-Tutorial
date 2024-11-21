import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Save',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
    );
  }
}
