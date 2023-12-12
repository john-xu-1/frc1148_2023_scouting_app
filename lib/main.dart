import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
//import 'package:frc1148_2023_scouting_app/team_display_choice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const log_in(title: 'Scouting Home Page'), //const team_display_choice() 
    );
  }
}

