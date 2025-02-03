// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // void getData() async {
  //   // Correctly parse the URL string to a Uri object
  //   Response response =
  //       await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  //   // Map stored data
  //   // Decode the data because previously it's a string
  //   Map data = jsonDecode(response.body);
  //   print(data);
  //   // Call item individually
  //   print(data['title']);
  // }

  void getTime() async {
    Response response = await get(
        Uri.parse('https://worldtimeapi.org/api/timezone/Australia/Melbourne'));
    Map data = jsonDecode(response.body);
    //print(data);

    // get properties from data
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(dateTime); - +11:00, 11
    // print(offset);

    // Create date time object - Its an object now
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset)));
    print(now);
  }

  @override
  void initState() {
    super.initState();
    // getData(); // Call the method when the widget is initialized
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Loading Screen',
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
