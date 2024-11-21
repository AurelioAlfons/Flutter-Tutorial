// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Stateless widget -> State of the widget that cannot change over time
// Stateful widget -> State of the widget that can change

// Using stateless widget enables for hot reload
// Hot realod only updates the widget with changes
// SO no need to rebuild everything
// Making the process quicker
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  ScaffoldExample({super.key});

  final ScrollController _refresh = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold BG color
      backgroundColor: const Color.fromARGB(255, 65, 255, 195),

      // AppBar
      appBar: AppBar(
        // Color
        backgroundColor: const Color.fromARGB(255, 68, 48, 219),
        // Icon Color
        iconTheme: const IconThemeData(color: Colors.white),
        // Title
        title: const Text(
          "Testing",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.precision_manufacturing_outlined))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _refresh,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "1: Using Image(image:image)",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 46, 231),
                          fontSize: 16,
                          // Font weight is to Make it bold
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    // Make spacing outsode of container
                    margin: const EdgeInsets.all(20),
                    // Wrap the Image inside a ClipRRect to change the border
                    child: ClipRRect(
                      // Setting the circular edge radius the same
                      borderRadius: BorderRadius.circular(20),

                      // Method 1 to add image
                      child: const Image(
                        // Using an Image Network from the Internet URL
                        image: NetworkImage(
                            'https://images.pexels.com/photos/28987663/pexels-photo-28987663/free-photo-of-daisy-close-up-with-alpine-autumn-landscape.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                        // Here's another way to add image
                        // We can use a network image
                        // Or an Asset image (Local saved)
                        // Make sure to declare asset folder in the pubsec.yml

                        // image: AssetImage('assets/name.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "2: Using Image.Network",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                        color: Color.fromARGB(255, 0, 46, 231)),
                  ),
                  // Spacing
                  const SizedBox(
                    height: 15,
                  ),

                  // Method 2 to add image
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          'https://images.pexels.com/photos/28905905/pexels-photo-28905905/free-photo-of-autumn-lakeside-fishing-in-beautiful-park.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load'),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.green,
                    padding: const EdgeInsets.fromLTRB(20, 50, 0, 30),
                    child: const Text(
                      "Hello",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Spacing
                  const SizedBox(
                    height: 800,
                  ),
                ],
              ),
            ),
          ),

          // Position widget to keep it place
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      // Adds shadow around the IconButton
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          spreadRadius: 2, // Spread of the shadow
                          blurRadius: 8, // Softness of the shadow
                          offset: const Offset(
                              0, 4), // Horizontal and vertical offset
                        ),
                      ],
                    ),
                    child: IconButton(
                      tooltip: 'Refresh',
                      hoverColor: Colors.white,
                      onPressed: () {
                        // ignore: avoid_print
                        print("You clicked this button");
                        // Will go to the Y = 0 offset
                        // Y as in like a graph index 0 -> goes up
                        // Screen goes down

                        _refresh.animateTo(0,
                            duration: const Duration(microseconds: 500000),
                            curve: Curves.easeInOut);
                      },
                      icon: const Icon(
                        Icons.local_airport,
                        size: 45,
                        color: Color.fromARGB(255, 0, 46, 231),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    onPressed: () {
                      _refresh.animateTo(1300,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.wifi_tethering,
                      size: 40,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Go To Bottom',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 68, 48, 219),
        onPressed: () {},
        child: const Icon(Icons.plus_one),
      ),

      // Bottom NavBar
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 68, 48, 219),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 1000,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
