import 'package:flutter/material.dart';
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
          print("Invalid coordinate format: $coord\n");
        }
      } catch (e) {
        print("Error parsing coordinate: $coord, Error: $e\n");
      }
    }
    for (var coord in coordinates) {
      print("(${coord.dx}, ${coord.dy})\n");
    }
    return coordinates;
  }

  // Updated fetchTeamFromSheets function
  Future<void> fetchTeamFromSheets() async {
    try {
      print('Fetching data from Google Sheets...\n');
      final sheet = await SheetsHelper.sheetSetup('Tracing');
      final rows = await sheet?.cells.allRows();
      if (rows != null) {
        print('Data fetched successfully. Parsing data...\n');
        for (var row in rows) {
          String match = row[9].value;
          String coordinates = row[1].value;
          // String team = row[10].value;
          print('Match: $match, Coordinates: $coordinates\n'); // Debug line
          List<Offset> points = parseAndConvertCoordinates(coordinates);
          if (!matchCoordinates.containsKey(match)) {
            matchCoordinates[match] = [];
          }
          matchCoordinates[match]!.addAll(points);
          if (!matchNumbers.contains(match)) {
            matchNumbers.add(match);
          }
          // matchCoordinates[team]!.addAll(points);
          // if (!matchNumbers.contains(team)) {
          //   matchNumbers.add(team);
          // }
        }
        print('Data parsing complete.\n');
        print('Available matches: $matchNumbers\n'); // Debug line
        setState(() {});
      }
    } catch (e) {
      print('Error: $e\n');
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
                  selectedMatch = value.trim();
                  print('Selected match: $selectedMatch\n'); // Debug line
                  if (matchCoordinates.containsKey(selectedMatch)) {
                    print('Match found: $selectedMatch\n'); // Debug line
                  } else {
                    print('Match not found: $selectedMatch\n'); // Debug line
                  }
                });
              },
            ),
          ),
          Expanded(
            child: selectedMatch.isNotEmpty
                ? CustomPaint(
                    size: Size(370, 370),
                    painter: RobotPathPainter(matchCoordinates[selectedMatch]!),
                  )
                : Center(child: Text('Enter a match number to view the graph')),
          ),
        ],
      ),
    );
  }
}

class RobotPathPainter extends CustomPainter {
  final List<Offset> points;
  final List<Color> robotColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.brown,
  ];

  RobotPathPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 1.0;
    // 
    // Draw grid
    // for (int i = 0; i <= 370; i += 10) {
    //   canvas.drawLine(
    //       Offset(i.toDouble(), 0), Offset(i.toDouble(), 370), paint);
    //   canvas.drawLine(
    //       Offset(0, i.toDouble()), Offset(370, i.toDouble()), paint);
    // }

    // Draw robot paths
    int colorIndex = 0;
    for (int i = 0; i < points.length; i += 6) {
      final pathPaint = Paint()
        ..color = robotColors[colorIndex % robotColors.length]
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final path = Path();
      if (points.isNotEmpty) {
        path.moveTo(points[i].dx, points[i].dy);
        for (int j = i; j < i + 6 && j < points.length; j++) {
          path.lineTo(points[j].dx, points[j].dy);
        }
      }
      canvas.drawPath(path, pathPaint);
      colorIndex++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    home: RobotPathGraph(),
  ));
}
