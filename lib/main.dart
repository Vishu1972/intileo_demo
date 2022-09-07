
import 'package:flutter/material.dart';
import 'package:newsapiintileotecno/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News Api",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}


