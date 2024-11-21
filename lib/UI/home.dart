import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            highlightColor:
                const Color.fromARGB(255, 10, 223, 134).withOpacity(0.2),
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            )),
        actions: [
          IconButton(
            highlightColor:
                const Color.fromARGB(255, 10, 223, 134).withOpacity(0.2),
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_outlined),
            color: Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
    );
  }
}
