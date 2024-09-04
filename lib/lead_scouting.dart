import 'package:flutter/material.dart';
import 'sheets_helper.dart';
import 'entrance.dart';

// bool coopertition = false;

// String effectiveness1 = "";
// String effectiveness2 = "";
// String effectiveness3 = "";

// String relPsdEffectiveness1 = "";
// String relPsdEffectiveness2 = "";
// String relPsdEffectiveness3 = "";

// String notes1 = "";
// String notes2 = "";
// String notes3 = "";

  PrimitiveWrapper effectiveness1 = PrimitiveWrapper(0); 
  PrimitiveWrapper effectiveness2 = PrimitiveWrapper(0); 
  PrimitiveWrapper effectiveness3 = PrimitiveWrapper(0);

  String relEffectiveness = "";

  String accuracy1 = "";
  String fieldAwareness1 = "";
  String trends1 = "";
  String robotFailure1 = "";
  String autoNotes1 = "";

  String accuracy2 = "";
  String fieldAwareness2 = "";
  String trends2 = "";
  String robotFailure2 = "";
  String autoNotes2 = "";

  String accuracy3 = "";
  String fieldAwareness3 = "";
  String trends3 = "";
  String robotFailure3 = "";
  String autoNotes3 = "";
  

class LeadScouting extends StatefulWidget {
  const LeadScouting({super.key, required this.teamName});
  final String teamName;
  @override
  State<LeadScouting> createState() => _LeadScouting();
}

class _LeadScouting extends State<LeadScouting> {
  final List<String> entries = <String>[
    'Enter Robot effectivness 5 is highest (1-5)',
    'Select relative effectivness 1 is highest (1-3)',
    'Enter Notes on robot (select Category)',
  ];

  
  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("Scouting Lead Notes"); // Replace with your sheet name    

       // Writing data
      final firstRow = [];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);

      print(await sheet.values.row(1));
  }catch (e) {
      print('Error: $e');
    }
  }

  void update(PrimitiveWrapper variable, int inc){
    setState(() {
      if ((variable.value + inc) >= 1 && (variable.value + inc) <= 5){
        variable.value += inc;
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( 
        title: Column(
          children: [
            const Text ("Lead Scouts",),
            Text(widget.teamName),
          ],
        ),
        
        elevation: 21,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
            height: height / 3.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(entries[0], textScaleFactor: 1.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CounterButton(update, effectiveness1, 1, const Text('+',textScaleFactor: 2,)),
                              CounterButton(update, effectiveness1, -1, const Text('-',textScaleFactor: 2.5,)),
                            ]
                          )
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CounterButton(update, effectiveness2, 1, const Text('+',textScaleFactor: 2,)),
                              CounterButton(update, effectiveness2, -1, const Text('-',textScaleFactor: 2.5,)),
                            ]
                          )
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CounterButton(update, effectiveness3, 1, const Text('+',textScaleFactor: 2,)),
                              CounterButton(update, effectiveness3, -1, const Text('-',textScaleFactor: 2.5,)),
                            ]
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: height / 3.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(entries[1], textScaleFactor: 1.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //will do dropdown here
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: height / 3.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(entries[2], textScaleFactor: 1.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            notes1 = value;
                          },
                          maxLines: null, // Setting maxLines to null allows multiple lines

                        ),
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            notes2 = value;
                          },
                          maxLines: null, // Setting maxLines to null allows multiple lines
                        ),
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            notes3 = value;
                          },
                          maxLines: null, // Setting maxLines to null allows multiple lines
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

            const Divider(),
            Container(
              width: width,
              height: height/5,
              //color: Colors.red[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Coopertition?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: coopertition,
                    //color: Colors.red[700],
                    onChanged: (newValue) {
                      setState(() {
                        coopertition = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(),

            ElevatedButton(
              onPressed: () async {
                await _submitForm();
                coopertition = false;
                Navigator.push(
                  context, 
                  MaterialPageRoute
                  (
                    builder: (context) => const Entrance()
                  )
                );
              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}

class CounterButton extends StatelessWidget{
  final Function func;
  final PrimitiveWrapper prim;
  final int inc;
  final Widget child;
  const CounterButton(this.func, this.prim, this.inc, this.child, {super.key});

  @override
  Widget build (BuildContext context){
    return IconButton(
      onPressed: () {
        func (prim, inc);
      },
      icon: child
    );
  }
  
}

class PrimitiveWrapper {
  int value = 0;
  PrimitiveWrapper(this.value);
}
//    @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar( 
//         title: Column(
//           children: [
//             const Text ("Lead Scouts",),
//             Text(widget.teamName),
//           ],
//         ),
        
//         elevation: 21,
//       ),
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             SizedBox(
//             height: height / 3.5,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(entries[0], textScaleFactor: 1.5,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             effectiveness1 = value;
//                             print("$value");
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             effectiveness2 = value;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             effectiveness3 = value;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(
//             height: height / 3.5,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(entries[1], textScaleFactor: 1.5,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             relPsdEffectiveness1 = value;
//                           },
//                         ),
//                       ),
//                       Container(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             relPsdEffectiveness2 = value;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             relPsdEffectiveness3 = value;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(
//             height: height / 3.5,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(entries[2], textScaleFactor: 1.5,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             notes1 = value;
//                           },
//                           maxLines: null, // Setting maxLines to null allows multiple lines

//                         ),
//                       ),
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             notes2 = value;
//                           },
//                           maxLines: null, // Setting maxLines to null allows multiple lines
//                         ),
//                       ),
//                       SizedBox(
//                         width: width / 3.5, // Adjust the width as needed
//                         child: TextField(
//                           onChanged: (String value) {
//                             notes3 = value;
//                           },
//                           maxLines: null, // Setting maxLines to null allows multiple lines
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//             const Divider(),
//             Container(
//               width: width,
//               height: height/5,
//               //color: Colors.red[300],
//               alignment: AlignmentDirectional.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text("Coopertition?",textScaleFactor: 1.5,),
//                   Checkbox(
//                     value: coopertition,
//                     //color: Colors.red[700],
//                     onChanged: (newValue) {
//                       setState(() {
//                         coopertition = newValue!;
//                       });
//                     },
//                   ),
//                 ]
//               ),
//             ),
//             const Divider(),

//             ElevatedButton(
//               onPressed: () async {
//                 await _submitForm();
//                 coopertition = false;
//                 Navigator.push(
//                   context, 
//                   MaterialPageRoute
//                   (
//                     builder: (context) => const Entrance()
//                   )
//                 );
//               },
//               child: const Icon(Icons.send),
//             )
//           ],
//         )
//       ),
//     );
//   }
// }