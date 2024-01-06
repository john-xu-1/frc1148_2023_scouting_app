import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For TapGestureRecognizer
import 'package:url_launcher/url_launcher.dart';
import 'entrance.dart';
import 'sheetsHelper.dart';


String robotWeight="";
bool one = false;
bool two = false;
String three = "";
bool fieldCapability = false;
SheetsHelper sh = SheetsHelper();


class pit_scouting extends StatefulWidget {
 const pit_scouting({super.key, required this.teamName});
  final String teamName;
  @override
  _pit_scouting createState() => _pit_scouting();
}

class _pit_scouting extends State<pit_scouting> {
  final List<String> entries = <String>[
    'Enter Robot Weight (lbs)',
    'Enter Robot score Capablity #1',
    'Enter Robot score Capablity #2',
    'Enter Robot bumper quality',
    'Maneuverability on field Capability',
  ];


  
  
  Future<void> _submitForm(column, row) async {
    try {
      final sheet = await sh.sheetSetup('PitScouting');
       // Writing data
      final firstRow = [robotWeight, one, two, three, fieldCapability];
      await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]
      print(await sheet.values.row(1));
  }catch (e) {
      print('Error: $e');
    }
  }


  // void _takePicture() async {
  //   final cameras = await availableCameras();
  //   final firstCamera = cameras.first;

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => tp.take_picture(camera: firstCamera),
  //     ),
  //   );
  // }
  
   @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pit Scouting", textScaleFactor: 1.5,),
        elevation: 21,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(width: 0, height: 60, color: Colors.white10,),

            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'link to ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    TextSpan(
                      text: 'Robot Pictures Folder',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://drive.google.com/drive/folders/17r61d7tOUQLiKA4cnEW15pXioTIKt-yK?usp=drive_link');
                        },
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: height / 3.5,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[0],textScaleFactor: 1.5,),
                    Container(
                      width: width /3,
                      child: TextField(
                        onChanged: (String value) {
                          robotWeight = (value);
                          print ("$value");
                        },
                        // decoration: const InputDecoration(
                        //   enabledBorder: UnderlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.red)
                        //   ),
                        //   disabledBorder: UnderlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.red)
                        //   ),
                        //   focusedBorder: UnderlineInputBorder(
                        //     borderSide: BorderSide( )
                        //   ),
                        // ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Container(
              height: height/3.5,
              //color: Colors.red[400],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[1],textScaleFactor: 1.5,),
                    Checkbox(
                    value: one,
                    //color: Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        one = newValue!;
                      });
                    },
                  ),
                  ],
                ),
              ),
            ),
            Container(
              height: height / 3.5,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[2],textScaleFactor: 1.5,),
                    Checkbox(
                    value: two,
                    //color: Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        two = newValue!;
                      });
                    },
                  )
                    
                  ],
                ),
              ),
            ),
            Container(
              height: height / 3.5,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[3],textScaleFactor: 1.5,),
                    Container(
                      width: width /3,
                      child: TextField(
                        onChanged: (String value) {
                          three = (value);
                          print ("$value");
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Container(
              height: height / 3.5,
              //color: Colors.red[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[4],textScaleFactor: 1.5,),
                    Checkbox(
                    value: fieldCapability,
                    //color: Colors.amber[700],
                    onChanged: (newValue) {
                      setState(() {
                        fieldCapability = newValue!;
                      });
                    },
                  )
                    
                  ],
                ),
              ),
            ),
            // Container (
            //   height: height / 10,
            //   width: width,
            //   //color: Colors.red ,
            //   alignment: Alignment.center,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text("Your team is: "),
            //       Text("$results"),
            //       IconButton(
            //         onPressed: (){
            //           teamAsker(test);
            //         }, 
            //         icon: const Icon (Icons.refresh)
            //       )
            //     ],
            //   )
            // ),
            

            
            // ElevatedButton(
            //   onPressed: _takePicture,
            //   child: const Icon(Icons.camera_alt),
            // ),
            
           

            ElevatedButton(
              onPressed: () {
                _submitForm(0,0);
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