import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/entrance.dart';
import 'auto_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: AutoForm(teamName: "1148"),//const Entrance(),
    );
  }
}

