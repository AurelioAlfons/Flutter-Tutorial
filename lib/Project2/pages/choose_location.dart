import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  int counter = 0;

  // Asynchronous function
  void getData() async {
    // Simulate a network request for username
    // Wait for 3 seconds (delay)
    String username = await Future.delayed(const Duration(seconds: 3), () {
      // ignore: avoid_print
      return 'yoshi';
    });

    String bio = await Future.delayed(const Duration(seconds: 2), () {
      // ignore: avoid_print
      return 'Vegan 2024';
    });

    // This will run first and won't interupt
    // ignore: avoid_print
    print('$username - $bio');
  }

  @override
  // Called once the widget is created
  // Subscribe to streams or any object that could change our widget data
  // init runs first
  void initState() {
    super.initState();
    getData();
  }

  @override
  // Build the widget tree
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Choose a location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: Text(
            'Choose Location',
            style: TextStyle(fontSize: 40),
          )),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  counter += 1;
                });
              },
              child: Text(
                'Counter is $counter',
                style: const TextStyle(fontSize: 35, color: Colors.black),
              ))
        ],
      ),
    );
  }
}
