import 'package:flutter/material.dart';
import 'package:flutter1/lessons/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback delete;

  const QuoteCard({super.key, required this.quote, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quote.text,
              style: TextStyle(fontSize: 18, color: Colors.grey[900]),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              quote.author,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton.icon(
              onPressed: delete,
              label: const Text(
                'Delete quote',
                style: TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
