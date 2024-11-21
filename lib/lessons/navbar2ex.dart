import 'package:flutter/material.dart';
import 'package:flutter1/lessons/rows.dart';
import 'package:flutter1/lessons/scaffold.dart';

class Navii extends StatefulWidget {
  const Navii({super.key});

  @override
  State<Navii> createState() => _NaviiState();
}

class _NaviiState extends State<Navii> {
  int _ourCurrentIndex = 0;

  List<Widget> listOfPages = const [MyRows(), ScaffoldExample()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfPages[_ourCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _ourCurrentIndex,
        onTap: (int newIndex) {
          setState(() {
            _ourCurrentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.work_history), label: 'A'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mic_external_off_sharp), label: 'B')
        ],
      ),
    );
  }
}
