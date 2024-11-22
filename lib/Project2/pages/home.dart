import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                label: const Text(
                  'Edit Location',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.black,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
