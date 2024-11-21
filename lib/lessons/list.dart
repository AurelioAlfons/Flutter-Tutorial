import 'package:flutter/material.dart';
import 'package:flutter1/lessons/quote.dart';
import 'package:flutter1/lessons/quote_card.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuoteList();
  }
}

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  // List
  List<Quote> quotes = [
    Quote(text: 'Be yourself dummy', author: 'Oscar Wilde'),
    Quote(text: 'Hi the force be with you', author: 'Pedro Pascal'),
    Quote(text: 'Halleluyah', author: 'Aurelio Alfons')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold Bg Color
      backgroundColor: Colors.grey[200],

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Awesome Quotes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // quoates => Define List name
          // .map => to transform each item in a list, change each quote into a Text(quote)
          // Text(quote) => Turns it into a Text Widget (Remember everything in flutter = widget)
          // toList => Converts result of map into a list
          // children: quotes
          //     .map((quote) => Text('${quote.text} - ${quote.author}'))
          //     .toList(),
          // children: quotes.map((quote) => quoteTemplate(quote)).toList(),
          children: quotes
              .map((quote) => QuoteCard(
                  quote: quote,
                  delete: () {
                    setState(() {
                      quotes.remove(quote);
                    });
                  }))
              .toList(),
        ),
      ),
    );
  }
}
