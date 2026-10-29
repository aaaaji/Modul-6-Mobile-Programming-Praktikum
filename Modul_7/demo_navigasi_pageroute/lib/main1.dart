import 'package:flutter/material.dart';
import 'home1.dart';
import 'tujuan1.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage1(),
        '/tujuan': (context) => const TujuanPage1(),
      },
    );
  }
}
