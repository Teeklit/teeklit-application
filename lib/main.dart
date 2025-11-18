// main.dart
import 'package:flutter/material.dart';
import 'package:teeklit/ui/teekle/widgets/teekle_select_workout.dart';

void main() {
  runApp(const TeeklitApp());
}

class TeeklitApp extends StatelessWidget {
  const TeeklitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF121212)),
      home: TeekleSelectWorkoutScreen(),
    );
  }
}
