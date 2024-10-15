import 'package:flutter/material.dart';
import 'sheets_helper.dart';

class RobotPathGraph extends StatefulWidget {
  const RobotPathGraph({super.key});

  @override
  State<RobotPathGraph> createState() => _RobotPathGraphState();
}

class _RobotPathGraphState extends State<RobotPathGraph> {
  Map<String, List<Map<String, dynamic>>> matchCoordinates = {};
  Map<String, List<Map<String, dynamic>>> teamAutos = {};
  String selectedIndex = '';
  List<String> matchNumbers = [];
  TextEditingController matchController = TextEditingController();
  String errorMessage = '';
  bool isIndexByTeam = false;

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

  Map<String, String> matchTeams = {};

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
          String team = row[10].value;
          String coordinates = row[1].value;
          bool isRed = row[13].value == 'true'; // Assuming the value is a string 'true' or 'false'
          if (!matchTeams.containsKey(match)){
            matchTeams[match] = "";
          }
          if (!teamAutos.containsKey(team)){
            print(team);
            teamAutos[team] = [];
          }
          matchTeams[match] = "${matchTeams[match]}${row[10].value} ";
          teamAutos[team]!.add({'coordinates': coordinates, 'isRed': isRed});
          // print('Match: $match, Coordinates: $coordinates, IsRed: $isRed\n'); // Debug line
          if (!matchCoordinates.containsKey(match)) {
            matchCoordinates[match] = [];
          }
          matchCoordinates[match]!.add({'coordinates': coordinates, 'isRed': isRed});
          if (!matchNumbers.contains(match)) {
            matchNumbers.add(match);
          }
        }
        print(teamAutos['frc6328']);
        print('Data parsing complete.\n');
        print('Available matches: $matchNumbers\n'); // Debug line
        setState(() {});
      }
    } catch (e) {
      print('Error: $e\n');
    }
  }
  
  // Helper function to split robot paths
  List<List<Offset>> splitRobotPaths(List<Map<String, dynamic>> rawCoordinates, bool isRed) {
    int numSelectedColorCoords = 0;
    for (Map<String, dynamic> data in rawCoordinates) {
      if (data['isRed'] == isRed) {
        numSelectedColorCoords++;
      }
    }
    List<List<Offset>> robotPaths = List.generate(numSelectedColorCoords, (_) => []);
    int coordsAdded = 0;
    for (int i = 0; i < rawCoordinates.length; i++) {
      if (rawCoordinates[i]['isRed'] == isRed) {
        Map<String, dynamic> data = rawCoordinates[i];
        List<Offset> coordinates = parseAndConvertCoordinates(data['coordinates'], data['isRed']);
        robotPaths[coordsAdded].addAll(coordinates);
        coordsAdded++;
      }
     
    }
    return robotPaths;
  }

  List<List<Offset>> splitRobotPathsByType(bool isRed, bool isIndexByTeam) {
    // return splitRobotPaths(matchCoordinates[selectedIndex]!, isRed);
    if (!isIndexByTeam) {
      if (!matchCoordinates.containsKey(selectedIndex)) {
        return [];
      }
      return splitRobotPaths(matchCoordinates[selectedIndex]!, isRed);
    }
    else {
      if (!teamAutos.containsKey('frc$selectedIndex')) {
        return [];
      }
      return splitRobotPaths(teamAutos['frc$selectedIndex']!, isRed);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Checkbox(
              value: isIndexByTeam,
              onChanged: (bool? value) {
                setState(() {
                  isIndexByTeam = value!;
                  print(isIndexByTeam);
                });
              },
            ),
          ),
          // Text input field for selecting match number
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: matchController,
              decoration: const InputDecoration(
                labelText: 'Enter Match Number',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String value) {
                setState(() {
                  selectedIndex = value.trim();
                  if (matchCoordinates.containsKey(selectedIndex) || isIndexByTeam) {
                    errorMessage = '';
                  } else {
                    errorMessage = 'Match not found: $selectedIndex';
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
            child: selectedIndex.isNotEmpty && (matchCoordinates.containsKey(selectedIndex) || isIndexByTeam)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // LegendWidget(
                        //   title: 'Blue Field Legend',
                        //   robotPaths: splitRobotPaths(matchCoordinates[selectedIndex]!, false),
                        // ),
                        /* Column(
                          children: [
                            const Text ("Blue Field Key"),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[0]),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[1]),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.purple,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[2]),
                              ],
                            ),
                          ],
                        ), */
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/blue_field.png'), fit: BoxFit.cover),
                          ),
                          child: SingleChildScrollView(
                            child: CustomPaint(
                              size: const Size(370, 370),
                              painter: RobotPathPainter(
                                splitRobotPathsByType(false, isIndexByTeam),
                              ),
                            ),
                          ),
                        ),
                        /* dColumn(
                          children: [
                            const Text ("Red Field Key"),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[3]),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[4]),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.purple,
                                ),
                                const SizedBox(width: 8),
                                Text(matchTeams[selectedIndex]!.split(" ")[5]),
                              ],
                            ),
                          ],
                        ), */
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/red_field.png'), fit: BoxFit.cover),
                          ),
                          child: SingleChildScrollView(
                            child: CustomPaint(
                              size: const Size(370, 370),
                              painter: RobotPathPainter(
                                splitRobotPathsByType(true, isIndexByTeam),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: Text('Enter a match number to view the graph')),
          ),
        ],
      ),
    );
  }
}

class RobotPathPainter extends CustomPainter {
  final List<List<Offset>> robotPaths;
  final List<Color> robotColors = [
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  RobotPathPainter(this.robotPaths);

  @override
  void paint(Canvas canvas, Size size) {
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

//create 2 size boxes each before their own field
//within each show the color of the robot and the number of the robot - 3 text lines