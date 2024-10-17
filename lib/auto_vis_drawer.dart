import 'package:flutter/material.dart';
import 'sheets_helper.dart';

class RobotPathGraph extends StatefulWidget {
  const RobotPathGraph({super.key});

  @override
  State<RobotPathGraph> createState() => _RobotPathGraphState();
}

class _RobotPathGraphState extends State<RobotPathGraph> {
  final List<List<Color>> gradients = [
    [
      Color.fromARGB(255, 67, 206, 162),
      const Color.fromARGB(255, 24, 90, 157)
    ],
    [
      Color.fromARGB(255, 255, 204, 133),
      Color.fromARGB(255, 253, 82, 84)
    ],
    [
      Color.fromARGB(255, 237, 30, 121),
      Color.fromARGB(255, 102, 45, 140)
    ],
  ];
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

  // Map<String, String> matchTeams = {};
  // Map<String, String> teamMatches = {};

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
          bool isRed = row[13].value ==
              'true'; // Assuming the value is a string 'true' or 'false'
          // if (!matchTeams.containsKey(match)) {
          //   matchTeams[match] = "";
          // }
          // matchTeams[match] = "${matchTeams[match]}$team ";
          // if (!teamMatches.containsKey(team)) {
          //   teamMatches[team] = "";
          // }
          // teamMatches[team] = "${teamMatches[team]}$match ";
          // print('Match: $match, Coordinates: $coordinates, IsRed: $isRed\n'); // Debug line
          if (!matchCoordinates.containsKey(match)) {
            matchCoordinates[match] = [];
          }
          matchCoordinates[match]!.add(
              {'coordinates': coordinates, 'teamNum': team, 'isRed': isRed});
          if (!teamAutos.containsKey(team)) {
            teamAutos[team] = [];
          }
          teamAutos[team]!.add({
            'coordinates': coordinates,
            'matchNum': 'q$match',
            'isRed': isRed
          });
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

  bool isIndexValid() {
    return isIndexByTeam
        ? teamAutos.containsKey('frc$selectedIndex')
        : matchCoordinates.containsKey(selectedIndex);
  }

  // Helper function to split robot paths
  List<List<Offset>> splitRobotPaths(bool isRed) {
    if (!isIndexValid()) {
      return [];
    }
    int numSelectedColorCoords = 0;
    List<Map<String, dynamic>> rawCoordinates = isIndexByTeam
        ? teamAutos['frc$selectedIndex']!
        : matchCoordinates[selectedIndex]!;
    for (Map<String, dynamic> data in rawCoordinates) {
      if (data['isRed'] == isRed) {
        numSelectedColorCoords++;
      }
    }
    List<List<Offset>> robotPaths =
        List.generate(numSelectedColorCoords, (_) => []);
    int coordsAdded = 0;
    for (int i = 0; i < rawCoordinates.length; i++) {
      if (rawCoordinates[i]['isRed'] == isRed) {
        Map<String, dynamic> data = rawCoordinates[i];
        List<Offset> coordinates =
            parseAndConvertCoordinates(data['coordinates'], data['isRed']);
        robotPaths[coordsAdded].addAll(coordinates);
        coordsAdded++;
      }
    }
    return robotPaths;
  }

  List<Widget> generateKey(bool isRed) {
    if (!isIndexValid()) {
      return [];
    }
    int numAdded = 0;
    List<Widget> keys = [Text("${isRed ? 'Red' : 'Blue'} Field Key")];
    List<Map<String, dynamic>> rawCoordinates = isIndexByTeam
        ? teamAutos['frc$selectedIndex']!
        : matchCoordinates[selectedIndex]!;
    for (Map<String, dynamic> match in rawCoordinates) {
      if (match['isRed'] == isRed) {
        keys.add(Row(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradients[numAdded]))),
            const SizedBox(width: 8),
            Text(match[isIndexByTeam ? 'matchNum' : 'teamNum']),
          ],
        ));
        numAdded = (numAdded + 1) % gradients.length;
      }
    }
    return keys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Robot Path Graph'),
      ),
      body: Column(
        children: [
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Indexing by match/team (uncheck for match, check for team):', textScaler: TextScaler.linear(0.75),),
              Checkbox(
                value: isIndexByTeam,
                onChanged: (bool? value) {
                  setState(() {
                    isIndexByTeam = value!;
                  });
                },
              ),
            ]
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
                  if (selectedIndex.isEmpty || isIndexValid()) {
                    errorMessage = '';
                  } else {
                    errorMessage =
                        '${isIndexByTeam ? 'Team' : 'Match'} not found: $selectedIndex';
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
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: isIndexValid()
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // LegendWidget(
                        //   title: 'Blue Field Legend',
                        //   robotPaths: splitRobotPaths(matchCoordinates[selectedIndex]!, false),
                        // ),
                        Column(children: generateKey(false)),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/blue_field.png'),
                                fit: BoxFit.cover),
                          ),
                          child: SingleChildScrollView(
                            child: CustomPaint(
                              size: const Size(370, 370),
                              painter: RobotPathPainter(
                                splitRobotPaths(false), gradients
                              ),
                            ),
                          ),
                        ),
                        Column(children: generateKey(true)),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/red_field.png'),
                                fit: BoxFit.cover),
                          ),
                          child: SingleChildScrollView(
                            child: CustomPaint(
                              size: const Size(370, 370),
                              painter: RobotPathPainter(
                                splitRobotPaths(true), gradients
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                        'Enter a valid ${isIndexByTeam ? 'team' : 'match'} number to view the graph')),
          ),
        ],
      ),
    );
  }
}

class RobotPathPainter extends CustomPainter {
  final List<List<Offset>> robotPaths;
  final List<List<Color>> gradients;

  // Function to help calculate color gradient
  Color calculateGradient(
      Color initialColor, Color finalColor, double percentComplete) {
    int redVal = initialColor.red +
        ((finalColor.red - initialColor.red) * percentComplete).toInt();
    int greenVal = initialColor.green +
        ((finalColor.green - initialColor.green) * percentComplete).toInt();
    int blueVal = initialColor.blue +
        ((finalColor.blue - initialColor.blue) * percentComplete).toInt();
    return Color.fromARGB(255, redVal, greenVal, blueVal);
  }

  RobotPathPainter(this.robotPaths, this.gradients);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw robot paths
    for (int i = 0; i < robotPaths.length; i++) {
      final pathPaint = Paint()
        ..color = gradients[i % gradients.length][0]
        ..strokeWidth = 5.0
        ..style = PaintingStyle.stroke;

      final points = robotPaths[i];
      final initialColor = gradients[i % gradients.length][0];
      final finalColor = gradients[i % gradients.length][1];

      if (points.isNotEmpty) {
        for (int i = 0; i < points.length - 1; i++) {
          pathPaint.color = calculateGradient(
              initialColor, finalColor, (i.toDouble() / points.length));
          canvas.drawLine(Offset(points[i].dx, points[i].dy),
              Offset(points[i + 1].dx, points[i + 1].dy), pathPaint);
        }
        pathPaint.style = PaintingStyle.fill;
        pathPaint.color = initialColor;
        canvas.drawCircle(Offset(points[0].dx, points[0].dy), 10.0, pathPaint);
        pathPaint.color = finalColor;
        canvas.drawCircle(
            Offset(points[points.length - 1].dx, points[points.length - 1].dy),
            10.0,
            pathPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//create 2 size boxes each before their own field
//within each show the color of the robot and the number of the robot - 3 text lines