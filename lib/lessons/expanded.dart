import 'package:flutter/material.dart';

void main() {
  runApp(const ExpandBith());
}

class ExpandBith extends StatelessWidget {
  const ExpandBith({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Declaring a scaffold will add a piece of paper on top of the UI
      home: Scaffold(
        //
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Aurelio"),
          centerTitle: true,
        ),

        body: Center(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  color: Colors.cyan,
                  child: const Text('1'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  color: Colors.pinkAccent,
                  child: const Text('2'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  color: Colors.greenAccent,
                  child: const Text('3'),
                ),
              ),
            ],
          ),
        ),

        //
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber,
          shape: const CircleBorder(),
          child: const Text("Click"),
        ),
      ),
    );
  }
}
