import 'package:flutter/material.dart';
import 'dart:async';
import 'sheets_helper.dart';

List<String> baller = List.empty(growable: true);
class DrawArea extends StatefulWidget {
  const DrawArea({super.key});

  @override
  _DrawAreaState createState() => _DrawAreaState();
}

class _DrawAreaState extends State<DrawArea> {
  List<Offset> points = <Offset>[];
  Timer? timer;

  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup('Tracing');
       // Writing data
      String out = ""; 
      for (int i = 0; i < baller.length; i++){
        out += baller[i] + " ";
      }
      List<String> allAutoValues = List.empty(growable: true);
      allAutoValues.add(out);
      await sheet!.values.insertRowByKey("robot match", allAutoValues);
      
      
    }catch (e) {
        print('Error: $e');
      }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (points.isNotEmpty && points.last.isFinite) {
        print('Current Cursor Coordinates: ${points.last}');
        baller.add (points.last.dx.toString() + "," + points.last.dy.toString());
        print (baller);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset point = box.globalToLocal(details.globalPosition);
            points = List.from(points)..add(point);
          });
        },
        onPanEnd: (DragEndDetails details) => points.add(Offset.infinite),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/blue_field.png'), fit: BoxFit.cover),
          ),
          child: CustomPaint(
            painter: Painter(points: points),
            size: Size.square(370), 
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
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
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
 
  @override
  bool shouldRepaint(Painter oldDelegate) => oldDelegate.points != points;
}