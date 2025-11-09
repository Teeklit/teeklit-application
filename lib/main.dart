// main.dart
import 'package:flutter/material.dart';
import 'package:teeklit/ui/teekle/teekle_main.dart';

void main() {
  runApp(const TeeklitApp());
}

class TeeklitApp extends StatelessWidget {
  const TeeklitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teeklit',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const TeekleMainScreen(),
    );
  }
}