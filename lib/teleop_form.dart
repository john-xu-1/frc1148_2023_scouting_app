import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/subjective_form.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';



  PrimitiveWrapper playerPointsToAdd = PrimitiveWrapper(0);

  PrimitiveWrapper speakerPoints = PrimitiveWrapper(0); 
  PrimitiveWrapper speakerAmpedCounter = PrimitiveWrapper(0); 
  PrimitiveWrapper speakerNotAmpedCounter = PrimitiveWrapper(0);
  
  PrimitiveWrapper ampPoints = PrimitiveWrapper(0);
  PrimitiveWrapper trapPoints = PrimitiveWrapper(0);

  PrimitiveWrapper missedS = PrimitiveWrapper(0);
  PrimitiveWrapper missedA = PrimitiveWrapper(0);
  PrimitiveWrapper missedT = PrimitiveWrapper(0);

  bool tryParkTele = false;
  bool messUpParkTele = false;
  int cycleCounter = 0;




class TeleopForm extends StatefulWidget {
  const TeleopForm({super.key, required this.teamName});
  final String teamName;
  @override
  State<TeleopForm> createState() => _TeleopForm();
}

class _TeleopForm extends State<TeleopForm> {

  


  Future<void> _submitSection() async {
    try {


      final sheet = await SheetsHelper.sheetSetup("App Results");

      // Writing data
      final firstRow = [speakerPoints.value, speakerAmpedCounter.value, speakerNotAmpedCounter.value, ampPoints.value, trapPoints.value, missedS.value, missedA.value, missedT.value,tryParkTele,messUpParkTele];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 3);
      

    } catch (e) {
      print('Error: $e');
    }
  }

  void update(PrimitiveWrapper variable, int inc){
    setState(() {
      if ((variable.value + inc) >= 0){
        variable.value += inc;
      }
      if (variable == speakerPoints && inc == 5){
        speakerAmpedCounter.value += 1;
      }
      if (variable == speakerPoints && inc == 1){
        speakerNotAmpedCounter.value += 1;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ 
                    ScoreDisplay(speakerPoints.value, "Speaker Pts: "),
                    Row(
                      children: [
                        SizedBox(
                          height: height/3,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Amplified",textScaleFactor: 1.5),
                              CounterButton(update, speakerPoints, 5, const Text('+',textScaleFactor: 2,)),
                              CounterButton(update, speakerPoints, -5, const Text('-',textScaleFactor: 2.5,)),
                              
                            ]
                          )
                        ),
                        SizedBox(
                          height: height/3,
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Regular",textScaleFactor: 1.5),
                              CounterButton(update, speakerPoints, 2, const Text('+',textScaleFactor: 2,)),
                              CounterButton(update, speakerPoints, -2, const Text('-',textScaleFactor: 2.5,)),
                            ]
                          )
                        ),
                      ],
                    ),

                    Container( alignment: AlignmentDirectional.center,width: width * 0.45,child: const Divider(color: colors.mySecondaryColor),),


                    ScoreDisplay(missedS.value, "Missed Speaker: "),

                    CounterButton(update, missedS, 1, const Text('+',textScaleFactor: 2,)),
                    CounterButton(update, missedS, -1, const Text('-',textScaleFactor: 2.5,)),
                  ],
                ),
                

                
                SizedBox(
                  height:height *0.9,
                  child: const VerticalDivider(color: colors.mySecondaryColor,),
                ),

                
                Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    ScoreDisplay(ampPoints.value, "Amp pts: "),

                    
                    
                    CounterButton(update, ampPoints, 1, const Text('+',textScaleFactor: 2,)),
                      
                    CounterButton(update, ampPoints, -1, const Text('-',textScaleFactor: 2.5,)),

                    const SizedBox(height: 165,),
                    

                    Container( alignment: AlignmentDirectional.center,width: width * 0.45,child: const Divider(color: colors.mySecondaryColor),),
                    ScoreDisplay(missedA.value, "Missed Amps: "),                            
                    CounterButton(update, missedA, 1, const Text('+',textScaleFactor: 2,)),
                    CounterButton(update, missedA, -1, const Text('-',textScaleFactor: 2.5,)),
                  ]
                ), 
              ]
            ),
            Container( 
              height: height/10,
              alignment: AlignmentDirectional.center,
              width: width * 0.4,
              //color: Colors.amber[100],
              child: const Text("Trap", textScaleFactor: 2.5,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScoreDisplay(trapPoints.value, "Points:"),
                    CounterButton(update, trapPoints, 5, const Text('+',textScaleFactor: 2,)),
                    CounterButton(update, trapPoints, -5, const Text('-',textScaleFactor: 2.5,)),
                    
                  ]
                ),
                const SizedBox(width: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [      
                      ScoreDisplay(missedT.value, "missed:"),                     
                      CounterButton(update,missedT, 1, const Text('+',textScaleFactor: 2,)),
                      CounterButton(update, missedT, -1, const Text('-',textScaleFactor: 2.5,)),
                  ]
                ),
              ],
            ),
 

            const Divider(color: colors.mySecondaryColor),
            Container(
              width: width,
              height: height/5,
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Try Hanging?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: tryParkTele,
                    onChanged: (newValue) {
                      setState(() {
                        tryParkTele = newValue!;
                      });
                    },
                  ),
                ]
              ),
            ),
            const Divider(color: colors.mySecondaryColor),
            Container(
              width: width,
              height: height/5,
              alignment: AlignmentDirectional.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Mess Up Hanging?",textScaleFactor: 1.5,),
                  Checkbox(
                    value: messUpParkTele,
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

class ScoreDisplay extends StatelessWidget{
  final int points;
  final String lable;
  const ScoreDisplay(this.points, this.lable, {super.key});

  @override
  Widget build (BuildContext context){
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(lable, textScaleFactor: 1.5,),
        SizedBox (width: width/20),
        FittedBox(child: Text("$points",textScaleFactor: 3.5, style: const TextStyle(color: colors.myOnPrimary))), 
      ],
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
