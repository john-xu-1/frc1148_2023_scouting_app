import 'package:flutter/material.dart';
import 'sheets_helper.dart';

class RobotPathGraph extends StatefulWidget {
  const RobotPathGraph({super.key});

  @override
  State<RobotPathGraph> createState() => _RobotPathGraphState();
}

class _RobotPathGraphState extends State<RobotPathGraph> {
  // Gradient colors for different robot paths
  // Each sublist contains start and end colors for the gradient
  final List<List<Color>> gradients = [
    [Color.fromARGB(255, 67, 206, 162), const Color.fromARGB(255, 24, 90, 157)],
    [Color.fromARGB(255, 255, 204, 133), Color.fromARGB(255, 253, 82, 84)],
    [Color.fromARGB(255, 237, 30, 121), Color.fromARGB(255, 102, 45, 140)],
  ];
  // Data structures to store information from different sheets
  Map<String, List<Map<String, dynamic>>> matchCoordinates =
      {}; // Stores paths by match
  Map<String, List<Map<String, dynamic>>> teamAutos =
      {}; // Stores paths by team
  Map<String, List<Map<String, dynamic>>> teamShots = {}; // Stores shot data
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
            dx = 370 - dx; // Mirror coordinates for red alliance
          }
          coordinates.add(Offset(dx, dy));
        } else {
          // print("Invalid coordinate format: $coord\n");
        }
      } catch (e) {
        // print("Error parsing coordinate: $coord, Error: $e\n");
      }
    }
    return coordinates;
  }

  // Map<String, String> matchTeams = {};
  // Map<String, String> teamMatches = {};

  // Updated fetchTeamFromSheets function to handle both sheets
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
          bool isRed = row[13].value == 'true';
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
          matchCoordinates[match]!.add({
            'coordinates': coordinates,
            'teamNum': team,
            'isRed': isRed,
          });

          if (!teamAutos.containsKey(team)) {
            teamAutos[team] = [];
          }
          teamAutos[team]!.add({
            'coordinates': coordinates,
            'matchNum': 'q$match',
            'isRed': isRed,
          });

          if (!matchNumbers.contains(match)) {
            matchNumbers.add(match);
          }
        }
        setState(() {});
      }

      // Fetch and parse shot data from App Results sheet
      final sheet2 = await SheetsHelper.sheetSetup('App results');
      final rows2 = await sheet2?.cells.allRows();
      if (rows2 != null) {
        print('App results sheet loaded, number of rows: ${rows2.length}');
        for (var row in rows2) {
          try {
            String matchTeamString = row[0].value;
            // print('Reading row with match/team: $matchTeamString');

            List<String> parts = matchTeamString.split(' ');
            String match =
                parts[0].substring(1); // Remove the 'q' from match number
            String team =
                parts[1].substring(3); // Remove the 'frc' from team number

            // print('Parsed match: $match, team: $team');

            String speakerShots = row[19].value;
            String speakerMissed = row[20].value;
            String ampShots = row[21].value;
            String ampMissed = row[22].value;
            String accuracy = row[24].value;

            // print(
            //     'Shot data: Speaker=$speakerShots, Amp=$ampShots, Accuracy=$accuracy');

            if (!teamShots.containsKey(match)) {
              teamShots[match] = [];
            }
            teamShots[match]!.add({
              'speaker shots': speakerShots,
              'speaker missed': speakerMissed,
              'amp shots': ampShots,
              'amp missed': ampMissed,
              'accuracy': accuracy,
              'teamNum': team,
            });

            // print('Added shot data for match $match team $team');
            // print('Current teamShots data: ${teamShots[match]}');
          } catch (e) {
            print('Error processing App results row: $e');
            print('Row data: ${row.map((cell) => cell.value).toList()}');
          }
        }
        // print('Final teamShots data: $teamShots');
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

  // Helper function to split robot paths by alliance color
  List<List<Offset>> splitRobotPaths(bool isRed) {
    if (!isIndexValid()) {
      return [];
    }
    int numSelectedColorCoords = 0;
    List<Map<String, dynamic>> rawCoordinates = isIndexByTeam
        ? teamAutos['frc$selectedIndex']!
        : matchCoordinates[selectedIndex]!;

    // Count paths for the selected alliance color
    for (Map<String, dynamic> data in rawCoordinates) {
      if (data['isRed'] == isRed) {
        numSelectedColorCoords++;
      }
    }
    List<List<Offset>> robotPaths =
        List.generate(numSelectedColorCoords, (_) => []);
    int coordsAdded = 0;

    // Process paths for this alliance
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

  // Generate the legend/key showing team numbers and shot data
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
        // Get the team number without the 'frc' prefix for lookup
        String teamNum = match['teamNum'].toString().replaceAll('frc', '');
        // Get match number without the 'q' prefix if present
        String matchNum = isIndexByTeam
            ? match['matchNum'].toString().replaceAll('q', '')
            : selectedIndex;

        Map<String, dynamic>? shotData = isIndexByTeam
            ? teamShots[matchNum]
                ?.firstWhere((shot) => shot['teamNum'] == selectedIndex,
                    orElse: () => {
                          'speaker shots': '0',
                          'speaker missed': '0',
                          'amp shots': '0',
                          'amp missed': '0',
                          'accuracy': '0'
                        })
            : teamShots[selectedIndex]
                ?.firstWhere((shot) => shot['teamNum'] == teamNum,
                    orElse: () => {
                          'speaker shots': '0',
                          'speaker missed': '0',
                          'amp shots': '0',
                          'amp missed': '0',
                          'accuracy': '0'
                        });

        try {
          // Handle DIV/0 or empty values
          var speakerShots =
              int.tryParse(shotData?['speaker shots']?.toString() ?? '0') ?? 0;
          var ampShots =
              int.tryParse(shotData?['amp shots']?.toString() ?? '0') ?? 0;
          var speakerMissed =
              int.tryParse(shotData?['speaker missed']?.toString() ?? '0') ?? 0;
          var ampMissed =
              int.tryParse(shotData?['amp missed']?.toString() ?? '0') ?? 0;
          var accuracy = shotData?['accuracy']?.toString() ?? '0';
          if (accuracy.contains('DIV')) accuracy = '0';

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
              const SizedBox(width: 8),
              Text(
                  " - Shots: ${speakerShots + ampShots + speakerMissed + ampMissed}"),
              const SizedBox(width: 8),
              Text(" - Accuracy: $accuracy%"),
            ],
          ));
        } catch (e) {
          print('Error processing shot data: $e');
        }
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Indexing by match/team (uncheck for match, check for team):',
              textScaler: TextScaler.linear(0.75),
            ),
            Checkbox(
              value: isIndexByTeam,
              onChanged: (bool? value) {
                setState(() {
                  isIndexByTeam = value!;
                });
              },
            ),
          ]),
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
              onChanged: (String value) {
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
                                  splitRobotPaths(false), gradients),
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
                                  splitRobotPaths(true), gradients),
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

// CustomPainter that handles drawing the robot paths with gradients
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
    // Draw robot paths with gradients
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