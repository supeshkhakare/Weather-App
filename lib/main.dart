import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false, // hides the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // initial screen
    );
  }
}
