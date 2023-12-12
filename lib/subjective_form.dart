import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
import 'sheetsHelper.dart';
import 'scouting_form.dart' as sf;
import 'teleop_form.dart' as tp;



  int speed = 0;
  int tippiness = 0;
  int roborating = 0;

  bool tip = false;
  bool defensive = false;
  bool ally = false;

  SheetsHelper sh = SheetsHelper();


class SubjectiveForm extends StatefulWidget {
  const SubjectiveForm({super.key, required this.teamName});
  final String teamName;
  @override
  _SubjectiveForm createState() => _SubjectiveForm();
}

class _SubjectiveForm extends State<SubjectiveForm> {

  void _add (score){
    if (score == "speed"){
      if (speed >= 0 && speed < 5) setState(() => speed += 1);
      print (speed);

    }
    else if (score == "tip"){
      if (tippiness >= 0 && tippiness < 5) setState(() => tippiness += 1);
      print (tippiness);
    }
    else if (score == "rating"){
      if (roborating >= 0 && roborating < 5) setState(() => roborating += 1);
      print (roborating);
    }
  }

  void _minus (score){
    if (score == "speed"){
      if (speed > 0 && speed <= 5) setState(() => speed -= 1);
      print (speed);

    }
    else if (score == "tip"){
      if (tippiness > 0 && tippiness <= 5) setState(() => tippiness -= 1);
      print (tippiness);
    }
    else if (score == "rating"){
      if (roborating > 0 && roborating <= 5) setState(() => roborating -= 1);
      print (roborating);
    }
  }

  
  


  Future<void> _submitSection() async {
    try {
      // final gsheets = GSheets(_creds);
      // final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      // final sheet = ss.worksheetByTitle('JohnTest');    
      //


      final sheet = await sh.sheetSetup("JohnTest"); 

      // Writing data
      
      final firstRow = [defensive, speed, tippiness, tip, roborating, ally];
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
            Column(
              children: [
                Container( 
                  height: height/20,
                  alignment: AlignmentDirectional.center,
                  //color Colors.amber[400],
                  child: const Text("How fast were they? (0-5)", textScaleFactor: 1.5,),
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
                            _add("speed"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$speed",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("speed"); 
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
            Column(
              children: [
                Container( 
                  height: height/20,
                  alignment: AlignmentDirectional.center,
                  //color Colors.amber[400],
                  child: const Text("What rating would you give this robot (0-5)", textScaleFactor: 1.2, textAlign: TextAlign.center,),
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
                            _add("rating"); 
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size(width, height/15),
                          ),
                          icon: const Icon(Icons.arrow_upward),
                      ),
                      Container(width: width/14, height: height/15, child: FittedBox(child: Text("$roborating",textScaleFactor: 3.5,),),), 
                      IconButton (
                          onPressed: () {
                            _minus("rating"); 
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
                  const Text("Should we ally /w them?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: ally,
                    //color Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        ally = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            ElevatedButton(
              onPressed: (){
                _submitSection();
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => const log_in(title: "test",)
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

                tp.topScoreCone = 0;
                tp.midScoreCone = 0;
                tp.lowScoreCone = 0;
                tp.topScoreCube = 0;
                tp.midScoreCube = 0;
                tp.lowScoreCube = 0;
                tp.tryParkTele = false;
                tp.messUpParkTele = false;
                tp.missedCone = 0;
                tp.missedCube = 0;

                


                
              },
              child: Text("Next"),
            )
          ]
      )   
    )
    );
  }
}
