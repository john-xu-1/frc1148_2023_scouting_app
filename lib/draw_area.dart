import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';
import 'better_teleop.dart';
// import 'teleop_form.dart';

// Global list to store coordinates as strings
List<String> coordinates = List.empty(growable: true);

class DrawArea extends StatefulWidget {
  const DrawArea({super.key, required this.teamName, required this.id});

  final String teamName;
  final String id;

  @override
  State<DrawArea> createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  // List to store the points drawn on the screen
  List<Offset?> points = <Offset?>[];
  // Timer to periodically log the current cursor position
  Timer? timer;
  bool isBenchFlipped = false;

  // Function to submit the form and save data to Google Sheets
  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("Tracing");

      // points = (points.map((point) => Offset(point!.dx, 370 - point!.dy))).toList();
      // coordinates = (points.map((point) => "${point!.dx},${point.dy}")).toList();

      if (isBenchFlipped &&
          (widget.id.toLowerCase() == "a" ||
              widget.id.toLowerCase() == "b" ||
              widget.id.toLowerCase() == "c")) {
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(370 - point.dx, 370 - point.dy))).toList();
        coordinates =
            (points.map((point) => "${point!.dx},${point.dy}")).toList();
      } else if (isBenchFlipped) {
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(point.dx, 370 - point.dy))).toList();
        coordinates =
            (points.map((point) => "${point!.dx},${point.dy}")).toList();
      } else if (!(widget.id.toLowerCase() == "a" ||
          widget.id.toLowerCase() == "b" ||
          widget.id.toLowerCase() == "c")) {
        points = (points.map((point) => point == null
            ? const Offset(0, 0)
            : Offset(370 - point.dx, point.dy))).toList();
        coordinates =
            (points.map((point) => "${point!.dx},${point.dy}")).toList();
      }

      String out = "";
      for (int i = 0; i < coordinates.length; i++) {
        out += "${coordinates[i]} ";
      }

      final firstRow = [out];
      if (widget.teamName.contains("frc")) {
        await sheet!.values
            .insertRowByKey(widget.teamName, firstRow, fromColumn: 2);
      } else {
        print('team name incorrect');
      }
      print('Data inserted successfully.');
      points = [];
      coordinates = [];
    } catch (e) {
      print('Error: $e');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the timer to log cursor coordinates every 200 milliseconds
  //   timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
  //     if (points.isNotEmpty && points.last != null) {
  //       // Uncomment the following lines if you need to log the cursor coordinates
  //       // print('Current Cursor Coordinates: ${points.last}');
  //       coordinates.add('${points.last!.dx},${points.last!.dy}');
  //       // print('Updated baller list: $baller');
  //     }
  //   });
  // }

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
          IconButton(
            onPressed: () {
              setState(() {
                points.clear();
                coordinates.clear();
              });
            },
            icon: const Icon(Icons.delete_outlined),
          ),
          Transform.rotate(
              angle: (3.1415 / 2),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    //if (points.length >= 2) points = points.sublist(0,points.length-2);

                    isBenchFlipped = !isBenchFlipped;
                  });
                },
                icon: const Icon(Icons.delete_outlined),
              )),
        ],
      ),
      body: GestureDetector(
        onTapDown: (details) {
          setState(() {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset point = box.globalToLocal(details.globalPosition);
            // Adjust the y-coordinate to account for the AppBar height
            point = Offset(point.dx, point.dy - appBarHeight);
            points.add(point);
            if (points.isNotEmpty && points.last != null) {
              coordinates.add('${points.last!.dx},${points.last!.dy}');
            }
          });
        },

        // onPanUpdate: (DragUpdateDetails details) {
        //   setState(() {
        //     RenderBox box = context.findRenderObject() as RenderBox;
        //     Offset point = box.globalToLocal(details.globalPosition);
        //     // Adjust the y-coordinate to account for the AppBar height
        //     point = Offset(point.dx, point.dy - appBarHeight);
        // //     points.add(point);
        //   });
        // },

        // onPanEnd: (DragEndDetails details) {
        //   setState(() {
        //     points.add(null); // Use null to signify the end of a stroke
        //   });
        // },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: bg,
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
                      BetterTeleop(teamName: widget.teamName)));
        },
        child: const Icon(Icons.send),
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
