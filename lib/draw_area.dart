import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';
import 'teleop_form.dart';

// Global list to store coordinates as strings
List<String> baller = List.empty(growable: true);

class DrawArea extends StatefulWidget {
  const DrawArea({super.key, required this.teamName});

  final String teamName;

  @override
  _DrawAreaState createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  // List to store the points drawn on the screen
  List<Offset?> points = <Offset?>[];
  // Timer to periodically log the current cursor position
  Timer? timer;

  // Function to submit the form and save data to Google Sheets
  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("Tracing");

      String out = "";
      for (int i = 0; i < baller.length; i++) {
        out += "${baller[i]} ";
      }

      final firstRow = [out];
      if (widget.teamName.contains("frc")) {
        await sheet!.values
            .insertRowByKey(widget.teamName, firstRow, fromColumn: 2);
      } else {
        print('team name incorrect');
      }
      print('Data inserted successfully.');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the timer to log cursor coordinates every 200 milliseconds
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (points.isNotEmpty && points.last != null) {
        // Uncomment the following lines if you need to log the cursor coordinates
        // print('Current Cursor Coordinates: ${points.last}');
        baller.add('${points.last!.dx},${points.last!.dy}');
        // print('Updated baller list: $baller');
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the height of the AppBar
    final double appBarHeight = AppBar().preferredSize.height;

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
          IconButton(
            onPressed: () {
              setState(() {
                points.clear();
                baller.clear();
              });
            },
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset point = box.globalToLocal(details.globalPosition);
            // Adjust the y-coordinate to account for the AppBar height
            point = Offset(point.dx, point.dy - appBarHeight);
            points.add(point);
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            points.add(null); // Use null to signify the end of a stroke
          });
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blue_field.png'),
              fit: BoxFit.cover,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitForm();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TeleopForm(teamName: widget.teamName)));
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset?> points;

  Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0; // Adjusted stroke width for better performance

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => true;
}
