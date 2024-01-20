import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/subjective_form.dart';
import 'sheets_helper.dart';
import 'subjective_form.dart' as subf;

SheetsHelper sh = SheetsHelper();


  // int topScoreCone = 0;
  // int midScoreCone = 0;
  // int lowScoreCone = 0;

  // int topScoreCube = 0;
  // int midScoreCube = 0;
  // int lowScoreCube = 0;

  // bool tryParkTele = false;
  // bool messUpParkTele = false;

  // int missedCone = 0;
  // int missedCube = 0;

  int speakerPoints = 0;
  int speakerAmpedCounter = 0;
  int speakerNotAmpedCounter = 0;
  
  int ampPoints = 0;
  int trapPoints = 0;

  int missedS = 0;
  int missedA = 0;
  int missedT = 0;

  bool tryParkTele = false;
  bool messUpParkTele = false;

  // A  S
  // +  +
  // -  -

  // +  +
  // -  -

  // + T -




class TeleopForm extends StatefulWidget {
  const TeleopForm({super.key, required this.teamName});
  final String teamName;
  @override
  State<TeleopForm> createState() => _TeleopForm();
}

class _TeleopForm extends State<TeleopForm> {

void _add (score){
  if (score == "regS"){
      if (speakerPoints >= 0) setState(() => speakerPoints += 2);
      speakerNotAmpedCounter+=1;
      print (speakerPoints);

    }
    else if (score == "AmpS"){
      if (speakerPoints >= 0) setState(() => speakerPoints += 5);
      speakerAmpedCounter+=1;
      print (speakerPoints);
    }
    else if (score == "missedS"){
      if (missedS >= 0) setState(() => missedS += 1);
    }
    else if (score == "regA"){
      if (ampPoints >= 0) setState(() => ampPoints += 1);
      print (ampPoints);

    }
    else if (score == "missedA"){
      if (missedA >= 0) setState(() => missedA += 1);
    }
    else if (score == "trap"){
      if (trapPoints>=0) setState(()=>trapPoints+=5);
    }
    else if (score == "missedT"){
      if (missedT >= 0) setState(() => missedT += 1);
    }
}
  
void _minus (score){
  if (score == "regS"){
      if (speakerPoints >= 2) setState(() => speakerPoints -= 2);
      speakerNotAmpedCounter-=1;
      print (speakerPoints);

    }
    else if (score == "AmpS"){
      if (speakerPoints >= 5) setState(() => speakerPoints -= 5);
      speakerAmpedCounter-=1;
      print (speakerPoints);
    }
    else if (score == "missedS"){
      if (missedS >= 1) setState(() => missedS -= 1);
    }
    else if (score == "regA"){
      if (ampPoints >= 1) setState(() => ampPoints -= 1);
      print (ampPoints);

    }
    else if (score == "missedA"){
      if (missedA >= 1) setState(() => missedA -= 1);
    }
    else if (score == "trap"){
      if (trapPoints>=5) setState(()=>trapPoints-=5);
    }
    else if (score == "missedT"){
      if (missedT >= 1) setState(() => missedT -= 1);
    }
}

  
  
  

  
  


  Future<void> _submitSection() async {
    try {
      // final gsheets = GSheets(_creds);
      // final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      // final sheet = ss.worksheetByTitle('JohnTest');


      final sheet = await sh.sheetSetup("JohnTest");

      // Writing data
      final firstRow = [speakerPoints, speakerAmpedCounter, speakerNotAmpedCounter, ampPoints, trapPoints, missedS, missedA];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 10);
      // prints [index, letter, number, label]
      print(await sheet.values.row(1));

    } catch (e) {
      print('Error: $e');
    }
  }

  
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
          const Text ("Teleop Phase",),
          Text(widget.teamName),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>
          [
            Row(
              children: [
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Row(
                      children: [
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.25,
                      //color: Colors.amber[100],
                      child: const Text("Speaker", textScaleFactor: 2.5,),
                    ),
                     SizedBox(width: width/14, height: height/10, child: FittedBox(child: Text("$speakerPoints",textScaleFactor: 3.5,),),), 
                    ],
                  ),


                    Row(
                      children: [
                
              
                      SizedBox(
                        height: height/3,
                        width: width * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width/2, height: height/20, child: FittedBox(child: Text("Amplified",textScaleFactor: 3.5),),), 
                            IconButton(
                              onPressed: () {
                                _add("AmpS"); 
                              },
                              style: IconButton.styleFrom(
                                  minimumSize: Size(width/2, height/10),
                                ),
                              icon: const Text('+',textScaleFactor: 4,)
                            ) ,
                            IconButton(
                              onPressed: () {
                                _minus("AmpS"); 
                              },
                              style: IconButton.styleFrom(
                                  minimumSize: Size(width/8, height/40),
                                ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                            )
                          ]
                        )
                      ),
                      
                      
                      SizedBox(
                        height: height/3,
                        width: width * 0.25,
                        //color: Colors.amber[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width/2, height: height/20, child: FittedBox(child: Text("Regular",textScaleFactor: 3.5),),),
                            IconButton (
                                onPressed: () {
                                  _add("regS"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/2, height/10),
                                ),
                              icon: const Text('+',textScaleFactor: 4,)
                            ),
                            IconButton (
                                onPressed: () {
                                  _minus("regS"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/8, height/40),
                                ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                    Row (
                      children:[
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.25,
                      //color: Colors.amber[100],
                      child: const Text("Missed Speaker", textScaleFactor: 2,),
                    ),
                    SizedBox(width: width/14, height: height/10, child: FittedBox(child: Text("$missedS",textScaleFactor: 3.5),),),
                      ],),
                    SizedBox(
                      height: height/3,
                      width: width * 0.50,
                      //color: Colors.amber[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _add("missedS"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/4, height/10),
                              ),
                              icon: const Text('+',textScaleFactor: 4,)
                          ) ,
                          ButtonTheme(
                            minWidth: width/14,
                            height: height/5,
                            child: IconButton(
                            onPressed: () {
                              _minus("missedS"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/8, height/40),
                            ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                            )
                          ),
                        ]
                      )
                    ),
                  ], 
                ),
                
                
                
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      //color: Colors.amber[100],
                      child: const Text("Amp", textScaleFactor: 2.5,),
                    ),
                     
                    
                    Row(children: [

                    
                    SizedBox(
                      height: height/3,
                      width: width * 0.25,
                      //color: Colors.amber[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children:[
                            SizedBox(width: width/8, height: height/20, child: FittedBox(child: Text("Points",textScaleFactor: 3.5),),),
                            SizedBox(width: width/8, height: height/15, child: FittedBox(child: Text("$ampPoints",textScaleFactor: 3.5,),),), 
                              ],),
                            IconButton(
                              onPressed: () {
                                _add("regA"); 
                              },
                              style: IconButton.styleFrom(
                                  minimumSize: Size(width/2, height/10),
                                ),
                              icon: const Text('+',textScaleFactor: 4,)
                            ) ,
                            IconButton(
                              onPressed: () {
                                _minus("regA"); 
                              },
                              style: IconButton.styleFrom(
                                  minimumSize: Size(width/8, height/40),
                                ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                          )
                        ]
                      )
                    ),
                    SizedBox(
                      height: height/3,
                      width: width * 0.25,
                      //color: Colors.amber[300],
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Row(
                              children:[
                            SizedBox(width: width/8, height: height/20, child: FittedBox(child: Text("Missed",textScaleFactor: 3.5),),),
                            SizedBox(width: width/8, height: height/15, child: FittedBox(child: Text("$missedA",textScaleFactor: 3.5,),),), 
                              ],),                            IconButton (
                                onPressed: () {
                                  _add("missedA"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/2, height/10),
                                ),
                              icon: const Text('+',textScaleFactor: 4,)
                            ),
                            IconButton (
                                onPressed: () {
                                  _minus("missedA"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/8, height/40),
                                ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                          )
                        ]
                      ),
                    ),
                    ],
                    ),
                  Container(
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      child: const Divider(),
                    ),
                  
                    Container( 
                      height: height/10,
                      alignment: AlignmentDirectional.center,
                      width: width * 0.5,
                      //color: Colors.amber[100],
                      child: const Text("Trap", textScaleFactor: 2.5,),
                    ),
                    

                      Row(
                        children:[
                    SizedBox(
                      height: height/3,
                      width: width * 0.25,
                      //color: Colors.amber[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              children:[
                            SizedBox(width: width/8, height: height/20, child: FittedBox(child: Text("Points",textScaleFactor: 3.5),),),
                            SizedBox(width: width/8, height: height/15, child: FittedBox(child: Text("$trapPoints",textScaleFactor: 3.5,),),), 
                              ],),
                          IconButton(
                            onPressed: () {
                              _add("trap"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/4, height/10),
                              ),
                              icon: const Text('+',textScaleFactor: 4,)
                          ) ,
                          ButtonTheme(
                            minWidth: width/14,
                            height: height/5,
                            child: IconButton(
                            onPressed: () {
                              _minus("trap"); 
                            },
                            style: IconButton.styleFrom(
                                minimumSize: Size(width/8, height/40),
                            ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                            )
                          ),
                          
                        ]
                      ),
                    ),
                   
                   //
                   SizedBox(
                      height: height/3,
                      width: width * 0.25,
                      //color: Colors.amber[300],
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children:[
                            SizedBox(width: width/8, height: height/20, child: FittedBox(child: Text("Missed",textScaleFactor: 3.5),),),
                            SizedBox(width: width/8, height: height/15, child: FittedBox(child: Text("$missedT",textScaleFactor: 3.5,),),), 
                              ],),                            IconButton (
                                onPressed: () {
                                  _add("missedT"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/2, height/10),
                                ),
                              icon: const Text('+',textScaleFactor: 4,)
                            ),
                            IconButton (
                                onPressed: () {
                                  _minus("missedT"); 
                                },
                                style: IconButton.styleFrom(
                                  minimumSize: Size(width/8, height/40),
                                ),
                              icon: const Text('-',textScaleFactor: 2.5,)
                          )
                        ]
                      ),
                    ),
                    //
                  ],),
                    //
                    //
                  ]
                ),  
              ]
            ),
 

            const Divider(),
            Container(
              width: width,
              height: height/5,
              //color: Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Try Parking?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tryParkTele,
                    //color: Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        tryParkTele = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(),
            Container(
              width: width,
              height: height/5,
              //color Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Mess Up Parking?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: messUpParkTele,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        messUpParkTele = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            ElevatedButton(
              onPressed: (){
                // subf.speed = 0;
                subf.tippiness = 0;
                // subf.roborating = 0;

                subf.tip = false;
                subf.defensive = false;
                // subf.ally = false;
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => SubjectiveForm(teamName: widget.teamName)
                    )
                  );
                });
                _submitSection();
              },
              child: const Text("Next"),
            )
          ]
        )
      )
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//           const Text ("Teleop Phase",),
//           Text(widget.teamName),
//           ],
//         ),
//       ),
//       body: Center(
//         child: ListView(
//           children: <Widget>[
//             Row(
//               children: [
//                 Column (
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [ 
//                     Container( 
//                       height: height/10,
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.50,
//                       //color: Colors.amber[100],
//                       child: Text("Cone", textScaleFactor: 2.5,),
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[600],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               _addCone("top"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_upward)
//                           ) ,
//                           SizedBox(width: width/14, height: height/75),
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$topScoreCone",textScaleFactor: 3.5,),),), 
//                           SizedBox(width: width/14, height: height/75),
//                           IconButton(
//                             onPressed: () {
//                               _minusCone("top"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_downward),
//                           )
//                         ]
//                       )
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[400],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton (
//                               onPressed: () {
//                                 _addCone("mid"); 
//                               },
//                               style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                               icon: const Icon(Icons.arrow_upward),
//                           ),
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$midScoreCone",textScaleFactor: 3.5,),),), 
//                           IconButton (
//                               onPressed: () {
//                                 _minusCone("mid"); 
//                               },
//                               style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                               icon: const Icon(Icons.arrow_downward),
//                           )
//                         ]
//                       )
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[300],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               _addCone("low"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_upward)
//                           ) ,
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$lowScoreCone",textScaleFactor: 3.5,),),), 
//                           ButtonTheme(
//                             minWidth: width/14,
//                             height: height/5,
//                             child: IconButton(
//                             onPressed: () {
//                               _minusCone("low"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                             ),
//                             icon: const Icon(Icons.arrow_downward),
//                           )
//                           ),
                          
//                         ]
//                       )
//                     ),
//                   ]
//                 ),
//                 Column (
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [ 
//                     Container( 
//                       height: height/10,
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.50,
//                       //color: Colors.amber[100],
//                       child: Text("Cube", textScaleFactor: 2.5,),
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[600],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               _addCube("top"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_upward)
//                           ) ,
//                           SizedBox(width: width/14, height: height/75),
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$topScoreCube",textScaleFactor: 3.5,),),), 
//                           SizedBox(width: width/14, height: height/75),
//                           IconButton(
//                             onPressed: () {
//                               _minusCube("top"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_downward),
//                           )
//                         ]
//                       )
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[400],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton (
//                               onPressed: () {
//                                 _addCube("mid"); 
//                               },
//                               style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                               icon: const Icon(Icons.arrow_upward),
//                           ),
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$midScoreCube",textScaleFactor: 3.5,),),), 
//                           IconButton (
//                               onPressed: () {
//                                 _minusCube("mid"); 
//                               },
//                               style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                               icon: const Icon(Icons.arrow_downward),
//                           )
//                         ]
//                       )
//                     ),
//                     Container(
//                       alignment: AlignmentDirectional.center,
//                       width: width * 0.5,
//                       child: const Divider(),
//                     ),
//                     Container(
//                       height: height/3,
//                       width: width * 0.50,
//                       //color: Colors.amber[300],
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               _addCube("low"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                               ),
//                             icon: const Icon(Icons.arrow_upward)
//                           ) ,
//                           Container(width: width/14, height: height/10, child: FittedBox(child: Text("$lowScoreCube",textScaleFactor: 3.5,),),), 
//                           ButtonTheme(
//                             minWidth: width/14,
//                             height: height/5,
//                             child: IconButton(
//                             onPressed: () {
//                               _minusCube("low"); 
//                             },
//                             style: IconButton.styleFrom(
//                                 minimumSize: Size(width/2, height/10),
//                             ),
//                             icon: const Icon(Icons.arrow_downward),
//                           )
//                           ),
//                         ]
//                       )
//                     ),
//                   ]
//                 ),
//               ],
//             ),
//             const Divider(),
//             Container(
//               width: width,
//               height: height/5,
//               //color: Colors.amber[300],
//               alignment: AlignmentDirectional.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text("Try Parking?",textScaleFactor: 1.5,),
//                   Checkbox(
//                     value: tryParkTele,
//                     //color: Colors.amber[700],
//                     onChanged: (newValue) {
//                       setState(() {
//                         tryParkTele = newValue!;
//                       });
//                     },
//                   ),
//                 ]
//               ),
//             ),
//             const Divider(),
//             Container(
//               width: width,
//               height: height/5,
//               //color Colors.amber[300],
//               alignment: AlignmentDirectional.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text("Mess Up Parking?",textScaleFactor: 1.5,),
//                   Checkbox(
//                     value: messUpParkTele,
//                     //color Colors.amber[700],
//                     onChanged: (newValue) {
//                       setState(() {
//                         messUpParkTele = newValue!;
//                       });
//                     },
//                   ),
//                 ]
//               ),
//             ),
//             const Divider(),
//             Column(
//               children: [
//                 Container( 
//                   height: height/20,
//                   alignment: AlignmentDirectional.center,
//                   //color Colors.amber[400],
//                   child: const Text("Missed", textScaleFactor: 1.5,),
//                 ),
//                 Container(
//                   height: height/5,
//                   width: width,
//                   //color Colors.amber[400],
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton (
//                           onPressed: () {
//                             _addCube("missed"); 
//                           },
//                           style: IconButton.styleFrom(
//                             minimumSize: Size(width, height/15),
//                           ),
//                           icon: const Icon(Icons.arrow_upward),
//                       ),
//                       Container(width: width/14, height: height/15, child: FittedBox(child: Text("$missedCube",textScaleFactor: 3.5,),),), 
//                       IconButton (
//                           onPressed: () {
//                             _minusCube("missed"); 
//                           },
//                           style: IconButton.styleFrom(
//                             minimumSize: Size(width, height/15),
//                           ),
//                           icon: const Icon(Icons.arrow_downward),
//                       )
//                     ]
//                   )
//                 ),

//               ],
//             ),
//             ElevatedButton(
//               onPressed: (){
//                 // subf.speed = 0;
//                 subf.tippiness = 0;
//                 // subf.roborating = 0;

//                 subf.tip = false;
//                 subf.defensive = false;
//                 // subf.ally = false;
//                 setState(() {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute
//                     (
//                       builder: (context) => SubjectiveForm(teamName: widget.teamName)
//                     )
//                   );
//                 });
//                 _submitSection();
//               },
//               child: Text("Next"),
//             )
            
//           ]
//       )   
//     )
//     );
//   }
// }
//}