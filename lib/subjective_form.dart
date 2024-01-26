import 'package:flutter/material.dart';
import 'entrance.dart';
import 'sheets_helper.dart';
import 'scouting_form.dart' as sf;
import 'teleop_form.dart' as tp;



  int tippiness = 0;

  bool tip = false;
  bool robotBreak = false;
  bool defensive = false;


class SubjectiveForm extends StatefulWidget {
  const SubjectiveForm({super.key, required this.teamName});
  final String teamName;
  @override
  State<SubjectiveForm> createState() => _SubjectiveForm();
}

class _SubjectiveForm extends State<SubjectiveForm> {

  void _add (score){
   if (score == "tip"){
      if (tippiness >= 0 && tippiness < 5) setState(() => tippiness += 1);
      print (tippiness);
    }
    
  }

  void _minus (score){
    if (score == "tip"){
      if (tippiness > 0 && tippiness <= 5) setState(() => tippiness -= 1);
      print (tippiness);
    }
  }

  
  


  Future<void> _submitSection() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("JohnTest"); 

      // Writing data
      
      final firstRow = [defensive, tippiness, robotBreak, tip];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 19);
      // prints [index, letter, number, label]
      print(firstRow);



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
          const Text ("Subjective Rating",),
          Text(widget.teamName),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              width: width,
              height: height/5,
              //color Colors.amber[300],
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Were they defensive?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: defensive,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        defensive = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(),
            // Column(
            //   children: [
            //     Container( 
            //       height: height/20,
            //       alignment: AlignmentDirectional.center,
            //       //color Colors.amber[400],
            //       child: const Text("How fast were they? (0-5)", textScaleFactor: 1.5,),
            //     ),
            //     Container(
            //       height: height/5,
            //       width: width,
            //       //color Colors.amber[400],
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           IconButton (
            //               onPressed: () {
            //                 _add("speed"); 
            //               },
            //               style: IconButton.styleFrom(
            //                 minimumSize: Size(width, height/15),
            //               ),
            //               icon: const Icon(Icons.arrow_upward),
            //           ),
            //           Container(width: width/14, height: height/15, child: FittedBox(child: Text("$speed",textScaleFactor: 3.5,),),), 
            //           IconButton (
            //               onPressed: () {
            //                 _minus("speed"); 
            //               },
            //               style: IconButton.styleFrom(
            //                 minimumSize: Size(width, height/15),
            //               ),
            //               icon: const Icon(Icons.arrow_downward),
            //           )
            //         ]
            //       )
            //     ),
            //   ],
            // ),
            Column(
              children: [
                Container( 
                  height: height/20,
                  alignment: AlignmentDirectional.center,
                  //color Colors.amber[400],
                  child: const Text("How tippy are they? (0-5)", textScaleFactor: 1.5,),
                ),
                Container(
                  height: height/5,
                  width: width,
                  //color Colors.amber[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton (
                          onPressed: () {
                            _add("tip"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$tippiness",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("tip"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_downward),
                      )
                    ]
                  )
                ),

              ],
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
                  const Text("Did they tip?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tip,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        tip = newValue!;
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
                  const Text("Did they break?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: robotBreak,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        robotBreak = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(),
            
            // Column(
            //   children: [
            //     Container( 
            //       height: height/20,
            //       alignment: AlignmentDirectional.center,
            //       //color Colors.amber[400],
            //       child: const Text("What rating would you give this robot (0-5)", textScaleFactor: 1.2, textAlign: TextAlign.center,),
            //     ),
            //     Container(
            //       height: height/5,
            //       width: width,
            //       //color Colors.amber[400],
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           IconButton (
            //               onPressed: () {
            //                 _add("rating"); 
            //               },
            //               style: IconButton.styleFrom(
            //                 minimumSize: Size(width, height/15),
            //               ),
            //               icon: const Icon(Icons.arrow_upward),
            //           ),
            //           Container(width: width/14, height: height/15, child: FittedBox(child: Text("$roborating",textScaleFactor: 3.5,),),), 
            //           IconButton (
            //               onPressed: () {
            //                 _minus("rating"); 
            //               },
            //               style: IconButton.styleFrom(
            //                 minimumSize: Size(width, height/15),
            //               ),
            //               icon: const Icon(Icons.arrow_downward),
            //           )
            //         ]
            //       )
            //     ),
            //   ],
            // ),
            // const Divider(),
            // Container(
            //   width: width,
            //   height: height/5,
            //   //color Colors.amber[300],
            //   alignment: AlignmentDirectional.center,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("Should we ally /w them?",textScaleFactor: 1.5,),
            //       Checkbox(
            //         value: ally,
            //         //color Colors.amber[700],
            //         onChanged: (newValue) {
            //           setState(() {
            //             ally = newValue!;
            //           });
            //         },
            //       ),
            //     ]
            //   ),
            // ),
            ElevatedButton(
              onPressed: (){
                _submitSection();
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => const Entrance()
                    )
                  );
                });
                
                sf.topScoreCone = 0;
                sf.midScoreCone = 0;
                sf.lowScoreCone = 0;
                sf.topScoreCube = 0;
                sf.midScoreCube = 0;
                sf.lowScoreCube = 0;
                sf.tryParkAuto = false;
                sf.missedCone = 0;
                sf.missedCube = 0;

                tp.speakerPoints = 0;
                tp.speakerAmpedCounter = 0;
                tp.speakerNotAmpedCounter = 0;
  
                tp.ampPoints = 0;
                tp.trapPoints = 0;

                tp.missedS = 0;
                tp.missedA = 0;

                


                
              },
              child: Text("Next"),
            )
          ]
      )   
    )
    );
  }
}
