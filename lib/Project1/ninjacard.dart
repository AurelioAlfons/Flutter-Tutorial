import 'package:flutter/material.dart';

class Ninjacard extends StatefulWidget {
  const Ninjacard({super.key});

  @override
  State<Ninjacard> createState() => _NinjacardState();
}

class _NinjacardState extends State<Ninjacard> {
  int ninjaLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main Scaffold BG
      backgroundColor: Colors.grey[900],
      // AppBar
      appBar: AppBar(
        title: const Text(
          'Ninja ID Card',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      // Body
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          // To align in to from the left (start)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item no 0
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/image/thumb.jpg'),
                radius: 40,
              ),
            ),
            Divider(
              height: 90,
              color: Colors.grey[800],
            ),

            // Item no 1
            const Text(
              'NAME',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            // Make Space here
            const SizedBox(
              height: 10,
            ),
            // Item no 2
            const Text(
              'AURELIO',
              style: TextStyle(
                  color: Colors.amberAccent,
                  letterSpacing: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),

            // Item no 3
            const Text(
              'CURRENT NINJA LEVEL',
              style: TextStyle(color: Colors.grey, letterSpacing: 2.0),
            ),
            // Make Space here
            const SizedBox(
              height: 10,
            ),
            // Item no 4
            Text(
              '$ninjaLevel',
              style: const TextStyle(
                  color: Colors.amberAccent,
                  letterSpacing: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(
                      Icons.mail,
                      color: Colors.grey[400],
                      size: 40,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'aurelioNinja@email.com',
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1),
                ),
              ],
            )
          ],
        ),
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        child: const Icon(
          Icons.plus_one,
          size: 35,
        ),
        onPressed: () {
          setState(() {
            ninjaLevel += 1;
          });
        },
      ),
    );
  }
}
