// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter1/Project1/ninjacard.dart';
import 'package:flutter1/UI/home.dart';
import 'package:flutter1/UI/starter.dart';
import 'package:flutter1/lessons/expanded.dart';
import 'package:flutter1/lessons/list.dart';
import 'package:flutter1/lessons/navbar.dart';
import 'package:flutter1/lessons/navbar2ex.dart';
import 'package:flutter1/lessons/scaffold_example.dart';

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: NavigationBro(),
        home: QuoteList());
  }
}
