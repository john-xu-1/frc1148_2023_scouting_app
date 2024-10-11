import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/auto_vis_drawer.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'package:frc1148_2023_scouting_app/draw_area.dart';
import 'package:frc1148_2023_scouting_app/entrance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Home Page',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      //   useMaterial3: true,
      // ),
      theme: ThemeData.from(colorScheme: colors()),
      home: const Entrance(),

    );
  }
}
