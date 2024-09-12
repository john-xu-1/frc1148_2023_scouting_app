import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';

class AutoVisualization extends StatefulWidget {
  const AutoVisualization({super.key});

  @override
  State<AutoVisualization> createState() => _AutoVisualization();
}

class _AutoVisualization extends State<AutoVisualization> {
  List<List<double>> grabCoords() {
    String rawData = "123,456 109,213 412,11 10,500 142,958";
    List<String> stringCoords = rawData.split(" ");
    List<List<double>> coordinates = stringCoords
        .map((coord) =>
            coord.split(",").map((val) => double.parse(val)).toList())
        .toList();
    // List<List<double>> coordinates = List<List<double>>.filled(
    //     stringCoords.length, List<double>.filled(2, 0));
    // List<String> coordinate;
    // for (String eachCoord : stringCoords) {

    // }
    for (int i = 0; i < coordinates.length; i++) {
      print("(" +
          coordinates[i][0].toString() +
          ", " +
          coordinates[i][1].toString() +
          ")");
    }
    return coordinates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
