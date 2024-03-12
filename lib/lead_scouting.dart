import 'package:flutter/material.dart';
import 'sheets_helper.dart';
import 'entrance.dart';
import 'color_scheme.dart';

bool coopertition = false;

String effectiveness1 = "";
String effectiveness2 = "";
String effectiveness3 = "";

String relPsdEffectiveness1 = "";
String relPsdEffectiveness2 = "";
String relPsdEffectiveness3 = "";

String notes1 = "";
String notes2 = "";
String notes3 = "";

class LeadScouting extends StatefulWidget {
  const LeadScouting({super.key, required this.teamName});
  final String teamName;
  @override
  State<LeadScouting> createState() => _LeadScouting();
}

class _LeadScouting extends State<LeadScouting> {
  final List<String> entries = <String>[
    'Enter Robot effectivness 5 is highest (1-5)',
    'Enter relative effectivness 1 is highest (1-3)',
    'Enter Notes on robot (strengths weaknesses ect.)',
    'Did the alliance press Coopertition button',
  ];

  String out = "";

  
  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("Scouting Lead Notes"); // Replace with your sheet name    

       // Writing data
      final firstRow = [coopertition, effectiveness1, notes1, effectiveness2, notes2, effectiveness3, notes3, relPsdEffectiveness1, relPsdEffectiveness2 ,relPsdEffectiveness3];
      await sheet!.values.insertRowByKey ("q${widget.teamName} $out", firstRow, fromColumn: 2);

      print(await sheet.values.row(1));
  }catch (e) {
      print('Error: $e');
    }
  }

  String temp = "";
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( 
        title: Column(
          children: [
            const Text ("Lead Scouts",),
            const Text ("please click done when inputting teams", textScaleFactor: 0.75,),
            Text (out),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width /3.5,
                        child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              temp = "frc$value";
                            });
                          },
                          onEditingComplete: (){
                            setState(() {
                              out += "$temp, ";
                            });
                          },
                          cursorColor: colors.myOnSurface,
                        ),
                      ),
                      SizedBox(
                        width: width /3.5,
                        child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              temp = "frc$value";
                            });
                          },
                          onEditingComplete: (){
                            setState(() {
                              out += "$temp, ";
                            });
                          },
                          cursorColor: colors.myOnSurface,
                        ),
                      ),
                      SizedBox(
                        width: width /3.5,
                        child: TextField(
                          onChanged: (String value) {
                            setState(() {
                              temp = "frc$value";
                            });
                          },
                          onEditingComplete: (){
                            setState(() {
                              out += temp;
                            });
                          },
                          cursorColor: colors.myOnSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  Text(entries[0], textScaleFactor: 1.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            effectiveness1 = value;
                            print("$value");
                          },
                        ),
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            effectiveness2 = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            effectiveness3 = value;
                          },
                        ),
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
                    children: <Widget>[
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            relPsdEffectiveness1 = value;
                          },
                        ),
                      ),
                      Container(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            relPsdEffectiveness2 = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: width / 3.5, // Adjust the width as needed
                        child: TextField(
                          onChanged: (String value) {
                            relPsdEffectiveness3 = value;
                          },
                        ),
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
              onPressed: () {
                _submitForm();
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