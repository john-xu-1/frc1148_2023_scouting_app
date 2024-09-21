import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';

// Global list to store coordinates as strings
List<String> baller = List.empty(growable: true);

class DrawArea extends StatefulWidget {
  const DrawArea({super.key});

  @override
  _DrawAreaState createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  // List to store the points drawn on the screen
  List<Offset> points = <Offset>[];
  // Timer to periodically log the current cursor position
  Timer? timer;

  // Function to submit the form and save data to Google Sheets
  Future<void> _submitForm() async {
    try {
      print('Setting up Google Sheets...');
      final sheet = await SheetsHelper.sheetSetup('Tracing');
      // Writing data
      String out = ""; 
      for (int i = 0; i < baller.length; i++) {
        out += baller[i] + " ";
      }
      List<String> allAutoValues = List.empty(growable: true);
      allAutoValues.add(out);
      print('Inserting data into Google Sheets...');
      await sheet!.values.insertRowByKey("robot match", allAutoValues);
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
      if (points.isNotEmpty && points.last.isFinite) {
        print('Current Cursor Coordinates: ${points.last}');
        baller.add(points.last.dx.toString() + "," + points.last.dy.toString());
        print('Updated baller list: $baller');
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
            const Text("Tracing"),
            // Text(widget.teamName), add something
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                points = [];
                baller = [];
                print('Cleared points and baller list.');
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
            points = List.from(points)..add(point);
            print('Added point: $point');
          });
        },
        onPanEnd: (DragEndDetails details) {
          setState(() {
            points.add(Offset.infinite);
            print('Pan ended, added Offset.infinite');
          });
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blue_field.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomPaint(
            painter: Painter(points: points),
            size: Size.square(370),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submitForm();
        },
        child: Icon(Icons.send),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final List<Offset> points;

  Painter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

     // Debug line to print the points list
    print('Current points list: $points');
    
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
        print('Drawing line from ${points[i]} to ${points[i + 1]}');
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => oldDelegate.points != points;
}