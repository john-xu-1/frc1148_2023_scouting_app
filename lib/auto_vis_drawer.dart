import 'package:flutter/material.dart';
import 'sheets_helper.dart';

  

// class AutoVisualization extends StatefulWidget {
//   const AutoVisualization({super.key});

//   @override
//   State<AutoVisualization> createState() => _AutoVisualization();
// }

// class _AutoVisualization extends State<AutoVisualization> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(); // Replace with your actual widget tree
//   }
// }

class RobotPathGraph extends StatefulWidget {
  @override
  _RobotPathGraphState createState() => _RobotPathGraphState();
}

class _RobotPathGraphState extends State<RobotPathGraph> {
  Map<String, List<Map<String, dynamic>>> matchCoordinates = {};
  String selectedMatch = '';
  List<String> matchNumbers = [];
  TextEditingController matchController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchTeamFromSheets();
  }

  // Function to parse coordinates string and convert to List<Offset>
  List<Offset> parseAndConvertCoordinates(String rawData, bool isRed) {
    List<String> stringCoords = rawData.split(" ");
    List<Offset> coordinates = [];

    for (var coord in stringCoords) {
      try {
        List<String> values = coord.split(",");
        if (values.length == 2) {
          double dx = double.parse(values[0]).roundToDouble();
          double dy = double.parse(values[1]).roundToDouble();
          if (isRed) {
            dx = 370 - dx;
          }
          coordinates.add(Offset(dx, dy));
        } else {
          print("Invalid coordinate format: $coord\n");
        }
      } catch (e) {
        print("Error parsing coordinate: $coord, Error: $e\n");
      }
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
          bool isRed = row[13].value == 'true'; // Assuming the value is a string 'true' or 'false'
          print('Match: $match, Coordinates: $coordinates, IsRed: $isRed\n'); // Debug line
          if (!matchCoordinates.containsKey(match)) {
            matchCoordinates[match] = [];
          }
          matchCoordinates[match]!.add({'coordinates': coordinates, 'isRed': isRed});
          if (!matchNumbers.contains(match)) {
            matchNumbers.add(match);
          }
        }
        print('Data parsing complete.\n');
        print('Available matches: $matchNumbers\n'); // Debug line
        setState(() {});
      }
    } catch (e) {
      print('Error: $e\n');
    }
  }

  // Helper function to split robot paths
  List<List<Offset>> splitRobotPaths(List<Map<String, dynamic>> rawCoordinates) {
    List<List<Offset>> robotPaths = List.generate(6, (_) => []);
    for (int i = 0; i < rawCoordinates.length; i++) {
      Map<String, dynamic> data = rawCoordinates[i];
      List<Offset> coordinates = parseAndConvertCoordinates(data['coordinates'], data['isRed']);
      robotPaths[i % 6].addAll(coordinates);
    }
    return robotPaths;
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
              decoration: const InputDecoration(
                labelText: 'Enter Match Number',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String value) {
                setState(() {
                  selectedMatch = value.trim();
                  if (matchCoordinates.containsKey(selectedMatch)) {
                    errorMessage = '';
                  } else {
                    errorMessage = 'Match not found: $selectedMatch';
                  }
                });
              },
            ),
          ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: selectedMatch.isNotEmpty && matchCoordinates.containsKey(selectedMatch)
                ? DecoratedBox(
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/blue_field.png'), fit: BoxFit.fitWidth),
                    ),
                    child: SingleChildScrollView(
                      child: CustomPaint(
                        size: const Size(370, 370),
                        painter: RobotPathPainter(
                          splitRobotPaths(matchCoordinates[selectedMatch]!),
                        ),
                      ),
                    ),
                )
                : Center(child: Text('Enter a match number to view the graph')),
          ),
        ],
      ),
    );
  }
}

class RobotPathPainter extends CustomPainter {
  final List<List<Offset>> robotPaths;
  final List<Color> robotColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.brown,
  ];

  RobotPathPainter(this.robotPaths);

  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 1.0;
    // Load the image as a ui.Image
    
    // // Draw grid
    // for (int i = 0; i <= 370; i += 10) {
    //   canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), 370), paint);
    //   canvas.drawLine(Offset(0, i.toDouble()), Offset(370, i.toDouble()), paint);
    // }

    // Draw robot paths
    for (int i = 0; i < robotPaths.length; i++) {
      final pathPaint = Paint()
        ..color = robotColors[i % robotColors.length]
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final path = Path();
      final points = robotPaths[i];
      if (points.isNotEmpty) {
        path.moveTo(points[0].dx, points[0].dy);
        for (var point in points) {
          path.lineTo(point.dx, point.dy);
        }
      }
      canvas.drawPath(path, pathPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}