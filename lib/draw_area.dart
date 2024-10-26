import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';
import 'teleop_form.dart';

// Global list to store path coordinates drawn by the scout
// These coordinates will be saved to track robot movement
List<String> coordinates = List.empty(growable: true);

// Wrapper class to allow passing primitive values by reference
// This enables updating counter values from child widgets
class PrimitiveWrapper {
  int value = 0;
  PrimitiveWrapper(this.value);
}

// Reusable button widget for incrementing/decrementing counters
// Used for tracking game piece scores and misses
class CounterButton extends StatelessWidget {
  final Function func; // Update function to call
  final PrimitiveWrapper prim; // Value to update
  final int inc; // Amount to increment/decrement
  final Widget child; // Button content (usually + or - icon)
  const CounterButton(this.func, this.prim, this.inc, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          func(prim, inc);
        },
        icon: child);
  }
}

// Widget to display a score counter with a label
// Used for showing Speaker/Amp scores and misses
class ScoreDisplay extends StatelessWidget {
  final int points; // Current point value to display
  final String lable; // Label text (e.g. "Speaker:", "Amp:")
  const ScoreDisplay(this.points, this.lable, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          lable,
          textScaleFactor: 1,
        ),
        SizedBox(width: width / 20),
        FittedBox(
            child: Text("$points",
                textScaleFactor: 3.5,
                style: const TextStyle(color: Colors.white))),
      ],
    );
  }
}

// Main widget for the robot path drawing and scoring interface
class DrawArea extends StatefulWidget {
  const DrawArea({super.key, required this.teamName, required this.id});

  final String teamName; // FRC team number being scouted
  final String id; // Alliance station ID (red/blue A/B/C)

  @override
  State<DrawArea> createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  // Store points for drawing the robot's path
  List<Offset?> points = <Offset?>[];
  Timer? timer;
  // Track if the field view should be flipped (for different alliance stations)
  bool isBenchFlipped = false;

  // Counters for tracking scoring attempts
  PrimitiveWrapper ampPoints = PrimitiveWrapper(0); // Successful amp scores
  PrimitiveWrapper missedA = PrimitiveWrapper(0); // Missed amp attempts
  PrimitiveWrapper speakerPoints =
      PrimitiveWrapper(0); // Successful speaker scores
  PrimitiveWrapper missedS = PrimitiveWrapper(0); // Missed speaker attempts

  // Update function for all counter buttons
  // Prevents counters from going negative
  void update(PrimitiveWrapper variable, int inc) {
    setState(() {
      if ((variable.value + inc) >= 0) {
        variable.value += inc;
      }
    });
  }

  // Submits scouting data to Google Sheets
  // Handles coordinate transformation based on alliance station
  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("Tracing");

      // Transform coordinates based on alliance station and field orientation
      if (isBenchFlipped &&
          (widget.id.toLowerCase() == "a" ||
              widget.id.toLowerCase() == "b" ||
              widget.id.toLowerCase() == "c")) {
        // Blue alliance with flipped field
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(370 - point.dx, 370 - point.dy))).toList();
      } else if (isBenchFlipped) {
        // Red alliance with flipped field
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(point.dx, 370 - point.dy))).toList();
      } else if (!(widget.id.toLowerCase() == "a" ||
          widget.id.toLowerCase() == "b" ||
          widget.id.toLowerCase() == "c")) {
        // Red alliance normal orientation
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(370 - point.dx, point.dy))).toList();
      }

      // Convert coordinates to string format for sheets
      String out = "";
      for (int i = 0; i < coordinates.length; i++) {
        out += "${coordinates[i]} ";
      }

      // Submit path data to Tracing sheet
      final coordRow = [out];
      if (widget.teamName.contains("frc")) {
        await sheet!.values
            .insertRowByKey(widget.teamName, coordRow, fromColumn: 2);
      } else {
        print('team name incorrect');
      }

      // Submit scoring data to App results sheet
      final sheet2 = await SheetsHelper.sheetSetup("App results");
      final pointsRow = [
        speakerPoints.value,
        missedS.value,
        ampPoints.value,
        missedA.value
      ];
      if (widget.teamName.contains("frc")) {
        await sheet2!.values
            .insertRowByKey(widget.teamName, pointsRow, fromColumn: 20);
      }

      print('Data inserted successfully.');
      points = [];
      coordinates = [];
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;

    // Load appropriate field background based on alliance and orientation
    AssetImage bg;
    if (widget.id.toLowerCase() == "a" ||
        widget.id.toLowerCase() == "b" ||
        widget.id.toLowerCase() == "c") {
      bg = isBenchFlipped
          ? const AssetImage('assets/blue_field_flip.jpeg')
          : const AssetImage('assets/blue_field.png');
    } else {
      bg = isBenchFlipped
          ? const AssetImage('assets/red_field_flip.png')
          : const AssetImage('assets/red_field.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Auto Phase",
            ),
            Text(widget.teamName),
          ],
        ),
        actions: [
          // Clear path button
          IconButton(
            onPressed: () {
              setState(() {
                points.clear();
                coordinates.clear();
              });
            },
            icon: const Icon(Icons.delete_outlined),
          ),
          // Flip field orientation button
          Transform.rotate(
              angle: (3.1415 / 2),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isBenchFlipped = !isBenchFlipped;
                  });
                },
                icon: const Icon(Icons.delete_outlined),
              )),
        ],
      ),
      body: Column(
        children: [
          // Field drawing area
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                RenderBox box = context.findRenderObject() as RenderBox;
                Offset point = box.globalToLocal(details.globalPosition);
                point = Offset(point.dx, point.dy - appBarHeight);
                points.add(point);
                if (points.isNotEmpty && points.last != null) {
                  coordinates.add('${points.last!.dx},${points.last!.dy}');
                }
              });
            },
            child: Container(
              width: 370, // Fixed width
              height: 370, // Fixed height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: bg,
                  fit: BoxFit
                      .fill, // Use fill to ensure image takes exact dimensions
                ),
              ),
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: Painter(points: points),
                  size: Size.square(370),
                ),
              ),
            ),
          ),
          // Scoring interface
          // Counter interface section - contains both scoring methods (Speaker and Amp)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Speaker scoring (5 points per score) with separate miss tracking
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ScoreDisplay(speakerPoints.value, "Speaker:"),
                  CounterButton(
                      update,
                      speakerPoints,
                      5,
                      const Text(
                        '+',
                        textScaleFactor: 1.5,
                      )),
                  CounterButton(
                      update,
                      speakerPoints,
                      -5,
                      const Text(
                        '-',
                        textScaleFactor: 2,
                      )),
                  const SizedBox(height: 5),
                  // Track missed shots separately from scoring
                  ScoreDisplay(missedS.value, "Missed:"),
                  CounterButton(
                      update,
                      missedS,
                      1,
                      const Text(
                        '+',
                        textScaleFactor: 1.5,
                      )),
                  CounterButton(
                      update,
                      missedS,
                      -1,
                      const Text(
                        '-',
                        textScaleFactor: 2,
                      )),
                ]),
                const SizedBox(
                  width: 50,
                ), // Space between scoring sections
                // Amp scoring (1 point per score) with separate miss tracking
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ScoreDisplay(ampPoints.value, "Amp:"),
                  CounterButton(
                      update,
                      ampPoints,
                      1,
                      const Text(
                        '+',
                        textScaleFactor: 1.5,
                      )),
                  CounterButton(
                      update,
                      ampPoints,
                      -1,
                      const Text(
                        '-',
                        textScaleFactor: 2,
                      )),
                  const SizedBox(height: 5),
                  // Track missed shots separately from scoring
                  ScoreDisplay(missedA.value, "Missed:"),
                  CounterButton(
                      update,
                      missedA,
                      1,
                      const Text(
                        '+',
                        textScaleFactor: 1.5,
                      )),
                  CounterButton(
                      update,
                      missedA,
                      -1,
                      const Text(
                        '-',
                        textScaleFactor: 2,
                      )),
                ]),
              ],
            ),
          ),
        ],
      ),
      // Submit button - saves data and moves to teleop form
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitForm();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeleopForm(teamName: widget.teamName)));
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

// Custom painter for drawing the robot's path on the field
class Painter extends CustomPainter {
  final List<Offset?> points;

  Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    // Draw lines between consecutive points to create the path
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => true;
}
