import 'package:flutter/material.dart';
import 'home3.dart';
import 'tujuan3.dart';

void main() {
  runApp(const MyApp3());
}

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage3(),
        '/tujuan': (context) => const TujuanPage3(),
      },
    );
  }
}
