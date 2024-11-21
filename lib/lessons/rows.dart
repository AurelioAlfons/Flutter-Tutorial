import 'package:flutter/material.dart';

void main() {
  runApp(const MyRows());
}

class MyRows extends StatelessWidget {
  const MyRows({super.key});

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

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.airplanemode_active,
                  size: 60,
                ),
                Icon(Icons.bus_alert, size: 60),
                Icon(Icons.local_shipping_sharp, size: 60),
                Icon(Icons.keyboard_option_key_sharp, size: 60),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // Containers 1-4
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(30),
                color: const Color.fromARGB(255, 0, 255, 42),
                child: const Text("Block 2"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.orange,
              child: const Text("Block 1"),
            ),
            Container(
              padding: const EdgeInsets.all(50),
              color: const Color.fromARGB(255, 0, 153, 255),
              child: const Text("Block 3"),
            ),
            Container(
              padding: const EdgeInsets.all(90),
              color: const Color.fromARGB(255, 255, 0, 191),
              child: const Text("Block 4"),
            ),
          ],
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
