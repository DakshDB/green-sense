import 'package:flutter/material.dart';
import 'package:green_sense/screens/home.dart';

void main() {
  runApp(const GreenSenseApp());
}

class GreenSenseApp extends StatelessWidget {
  const GreenSenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Sense',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Home(),
    );
  }
}
