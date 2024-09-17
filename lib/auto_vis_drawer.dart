import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'sheets_helper.dart';


class AutoVisualization extends StatefulWidget {
  const AutoVisualization({super.key});

  @override
  State<AutoVisualization> createState() => _AutoVisualization();
}

class _AutoVisualization extends State<AutoVisualization> {
  @override
  Widget build(BuildContext context) {
    return Container(); // Replace with your actual widget tree
  }
}

class RobotPathGraph extends StatefulWidget {
  @override
  _RobotPathGraphState createState() => _RobotPathGraphState();
}

class _RobotPathGraphState extends State<RobotPathGraph> {
  Map<String, List<Offset>> matchCoordinates = {};
  String selectedMatch = '';
  List<String> matchNumbers = [];
  TextEditingController matchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTeamFromSheets();
  }

  // Function to parse coordinates string and convert to List<Offset>
  List<Offset> parseAndConvertCoordinates(String rawData) {
    List<String> stringCoords = rawData.split(" ");
    List<Offset> coordinates = [];
    for (var coord in stringCoords) {
      try {
        List<String> values = coord.split(",");
        if (values.length == 2) {
          double dx = double.parse(values[0]);
          double dy = double.parse(values[1]);
          coordinates.add(Offset(dx, dy));
        } else {
          print("Invalid coordinate format: $coord");
        }
      } catch (e) {
        print("Error parsing coordinate: $coord, Error: $e");
      }
    }
    for (var coord in coordinates) {
      print("(${coord.dx}, ${coord.dy})");
    }
    return coordinates;
  }

  // Updated fetchTeamFromSheets function
  Future<void> fetchTeamFromSheets() async {
    try {
      print('Fetching data from Google Sheets...');
      final sheet = await SheetsHelper.sheetSetup('Tracing');
      final rows = await sheet?.cells.allRows();
      if (rows != null) {
        print('Data fetched successfully. Parsing data...');
        for (var row in rows) {
          String match = row[0].value;
          String coordinates = row[1].value;
          print('Match: $match, Coordinates: $coordinates'); // Debug line
          List<Offset> points = parseAndConvertCoordinates(coordinates);
          if (!matchCoordinates.containsKey(match)) {
            matchCoordinates[match] = [];
          }
          matchCoordinates[match]!.addAll(points);
          if (!matchNumbers.contains(match)) {
            matchNumbers.add(match);
          }
        }
        print('Data parsing complete.');
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Path Graph'),
      ),
      body: Column(
        children: [
          // Text input field for selecting match number
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: matchController,
              decoration: InputDecoration(
                labelText: 'Enter Match Number',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String value) {
                setState(() {
                  selectedMatch = value;
                  print('Selected match: $selectedMatch'); // Debug line
                });
              },
            ),
          ),
          Expanded(
            child: selectedMatch.isNotEmpty
                ? LineChart(LineChartData(
                    lineBarsData: _buildLineBarsData(),
                  ))
                : Center(child: Text('Enter a match number to view the graph')),
          ),
        ],
      ),
    );
  }

  // Builds the line chart data for the selected match
  List<LineChartBarData> _buildLineBarsData() {
    List<LineChartBarData> lineBarsData = [];
    if (matchCoordinates.containsKey(selectedMatch)) {
      List<Offset> points = matchCoordinates[selectedMatch]!;
      print('Building line chart data for match: $selectedMatch'); // Debug line
      for (int i = 0; i < points.length; i += 6) {
        List<FlSpot> spots = [];
        for (int j = i; j < i + 6 && j < points.length; j++) {
          spots.add(FlSpot(points[j].dx, points[j].dy));
        }
        lineBarsData.add(LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue, // Use single color for each robot
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
        ));
        print('Added line for robot with points: $spots'); // Debug line
      }
    } else {
      print('No data found for match: $selectedMatch'); // Debug line
    }
    return lineBarsData;
  }
}

void main() {
  runApp(MaterialApp(
    home: RobotPathGraph(),
  ));
}