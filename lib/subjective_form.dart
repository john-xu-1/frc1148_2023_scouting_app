import 'package:flutter/material.dart';
import 'entrance.dart';
import 'sheets_helper.dart';
import 'auto_form.dart' as af;
import 'teleop_form.dart' as tf;



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
      
      final firstRow = [defensive, tippiness, robotBreak, tip];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 13);



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
                  child: const Text("How tippy are they? (0-5)", textScaleFactor: 1.5,),
                ),
                SizedBox(
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
                      SizedBox(width: width/14, height: height/15, child: FittedBox(child: Text("$tippiness",textScaleFactor: 3.5,),),), 
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

                af.autoPath = "";

                tf.speakerPoints.value = 0;
                tf.speakerAmpedCounter.value = 0;
                tf.speakerNotAmpedCounter.value = 0;
                tf.ampPoints.value = 0;
                tf.trapPoints.value = 0; 
                tf.missedS.value = 0;
                tf.missedA.value = 0;
                tf.missedT.value = 0;
                tf.tryParkTele = false;
                tf.messUpParkTele = false;

                
                tippiness = 0;
                tip = false;
                defensive = false;
                robotBreak = false;
                
                

              },
              child: const Text("Next"),
            )
          ]
      )   
    )
    );
  }
}
