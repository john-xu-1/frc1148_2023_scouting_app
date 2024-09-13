import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';

class AutoVisualization extends StatefulWidget {
  const AutoVisualization({super.key});

  @override
  State<AutoVisualization> createState() => _AutoVisualization();
}

@override
void initState() {
  fetchTeamFromSheets();
}

Future<String> _fetchForm(column, row) async {
  try {
    final sheet = await SheetsHelper.sheetSetup(
        'Tracing'); // Replace with your sheet name

    // Writing data
    final cell = await sheet?.cells.cell(column: column, row: row);
    return (cell!.value);
  } catch (e) {
    print('Error: $e');
    return "";
  }
}

String coordData = "";

void fetchTeamFromSheets() async {
  coordData = (await _fetchForm(2, 1));
}

class _AutoVisualization extends State<AutoVisualization> {
  List<List<double>> grabCoords() {
    String rawData = coordData;
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
  // Widget build(BuildContext context) {
  //   return Scaffold();
  // }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    fetchTeamFromSheets();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Auto visualization",
          textScaleFactor: 1.5,
        ),
        elevation: 21,
      ),
    );
  }
}
