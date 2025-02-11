import 'package:flutter/material.dart';
import 'sheets_helper.dart';
import 'entrance.dart';
import 'color_scheme.dart';

PrimitiveWrapper effectiveness1 = PrimitiveWrapper(1);
PrimitiveWrapper effectiveness2 = PrimitiveWrapper(1);
PrimitiveWrapper effectiveness3 = PrimitiveWrapper(1);
int curEffect1 = 0;
int curEffect2 = 0;
int curEffect3 = 0;

int curRelEffect1 = 0;
int curRelEffect2 = 0;
int curRelEffect3 = 0;


String relEffectiveness = "";

// String accuracy1 = "";
// String fieldAwareness1 = "";
// String capabilities1 = "";
// String trends1 = "";
// String robotFailure1 = "";
// String autoNotes1 = "";
TextEditingController activeNote1 = TextEditingController();

// String accuracy2 = "";
// String fieldAwareness2 = "";
// String capabilities2 = "";
// String trends2 = "";
// String robotFailure2 = "";
// String autoNotes2 = "";
TextEditingController activeNote2 = TextEditingController();

// String accuracy3 = "";
// String fieldAwareness3 = "";
// String capabilities3 = "";
// String trends3 = "";
// String robotFailure3 = "";
// String autoNotes3 = "";
TextEditingController activeNote3 = TextEditingController();

List<List<String>> noteMatrix = [
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
  ["", "", ""]
];

List<TextEditingController> activeNoteControllers = [
  activeNote1,
  activeNote2,
  activeNote3
];

List<int> activeNoteType = [0, 0, 0];

var nameToInt = {
  "Auto Notes": 0,
  "Accuracy": 1,
  "Capabilities": 2,
  "Trends": 3,
  "Field Awareness": 4,
  "Robot Failures": 5,
};

//String selectedItem = "1, 2, 3";

// enum ColorLabel {
//   onetwothree('1, 2, 3', Colors.black),
//   onethreetwo('1, 3, 2', Colors.red),
//   twoonethree('2, 1, 3', Colors.blue),
//   twothreeone('2, 3, 1', Colors.purple),
//   threeonetwo('3, 1, 2', Colors.green),
//   threetwoone('3, 2, 1', Colors.orange);

//   const ColorLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }

class LeadScouting extends StatefulWidget {
  const LeadScouting({super.key, required this.teamName});
  final String teamName;
  @override
  State<LeadScouting> createState() => _LeadScouting();
}

class _LeadScouting extends State<LeadScouting> {
  final List<String> entries = <String>[
    'Enter robot effectiveness: 5 is highest (1-5)',
    'Select relative effectiveness: 1 is highest (1-3)',
    'Enter notes on robot (select category)',
  ];

  Future<void> _submitForm() async {
    try {
      final sheet = await SheetsHelper.sheetSetup(
          "NotesOrg"); // Replace with your sheet name

      List<String> relEffectivenessList = relEffectiveness.split(', ');
      print(relEffectiveness);
      print(relEffectivenessList);

      // Writing data
      final firstRow = [
        noteMatrix[0][0],
        noteMatrix[1][0],
        noteMatrix[2][0],
        noteMatrix[3][0],
        noteMatrix[4][0],
        noteMatrix[5][0],
        effectiveness1.value + curEffect1,
        (int.parse(relEffectivenessList[0]) + curRelEffect1),
      ];
      final secondRow = [
        noteMatrix[0][1],
        noteMatrix[1][1],
        noteMatrix[2][1],
        noteMatrix[3][1],
        noteMatrix[4][1],
        noteMatrix[5][1],
        (effectiveness2.value + curEffect2),
        (int.parse(relEffectivenessList[1])+ curRelEffect2),
      ];
      final thirdRow = [
        noteMatrix[0][2],
        noteMatrix[1][2],
        noteMatrix[2][2],
        noteMatrix[3][2],
        noteMatrix[4][2],
        noteMatrix[5][2],
        (effectiveness3.value + curEffect3),
        (int.parse(relEffectivenessList[2]) + curRelEffect3),
      ];

      List<String> teams = widget.teamName.split(' ');
      String robotOne = teams[1].substring(0, teams[1].length - 1);
      String robotTwo = teams[2].substring(0, teams[2].length - 1);
      String robotThree = teams[3];
      List<String> teamNames = [robotOne, robotTwo, robotThree];

      //q5 frc555, frc777, frc888

      List<List<dynamic>> rows = [firstRow, secondRow, thirdRow];

      for (int i = 0; i < 3; i++) {
        await sheet!.values
            .insertRowByKey(teamNames[i], rows[i], fromColumn: 2);
      }
      // await sheet!.values.insertRowByKey(
      //   widget.teamName, [firstRow, secondRow, thirdRow],fromColumn: 2
      // );
    } catch (e) {
      print('Error: $e');
    }
  }

  void reset() {
    effectiveness1 = PrimitiveWrapper(1);
    effectiveness2 = PrimitiveWrapper(1);
    effectiveness3 = PrimitiveWrapper(1);
    relEffectiveness = "";
    activeNote1.clear();
    activeNote1.clear();
    activeNote1.clear();
    noteMatrix = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""],
      ["", "", ""],
      ["", "", ""],
      ["", "", ""]
    ];
  }

  Future<void> setUp() async {
    List<String> teams = widget.teamName.split(' ');
    String robotOne = teams[1].substring(0, teams[1].length - 1);
    String robotTwo = teams[2].substring(0, teams[2].length - 1);
    String robotThree = teams[3];
    List<String> teamNames = [robotOne, robotTwo, robotThree];

    //this print out the teamnames that the set up is looking for in the spreadsheet
    print(widget.teamName);
    print("" + teamNames[0]);
    print(teamNames[1]);
    print(teamNames[2]);

    //if the team isn't there _fetchForm will get from row 100 and fill the notematrix with "."
    //this is because I am too lazy to do null checks??
    List<String> team1 = await _fetchForm(teamNames[0]);
    List<String> team2 = await _fetchForm(teamNames[1]);
    List<String> team3 = await _fetchForm(teamNames[2]);
    String checkingStr = "";

    if (team1[7] == checkingStr) {
      curEffect1 = 0;
    } else {
      curEffect1 = int.parse(team1[7]);
    }
    if (team2[7] == checkingStr) {
      curEffect2 = 0;
    } else {
      print(team2[7]);
      curEffect2 = int.parse(team2[7]);
    }
    if (team3[7] == checkingStr) {
      curEffect3 = 0;
    } else {
      curEffect3 = int.parse(team3[7]);
    }

    if (team1[8] == checkingStr) {
      curRelEffect1 = 0;
    } else {
      curRelEffect1 = int.parse(team1[8]);
    }
    if (team2[8] == checkingStr) {
      curRelEffect2 = 0;
    } else {
      curRelEffect2 = int.parse(team2[8]);
    }
    if (team3[8] == checkingStr) {
      curRelEffect3 = 0;
    } else {
      curRelEffect3 = int.parse(team3[8]);
    }

    print(curEffect1);
    print(curRelEffect1);

    setState(() {
      noteMatrix = [
        [team1[1], team2[1], team3[1]],
        [team1[2], team2[2], team3[2]],
        [team1[3], team2[3], team3[3]],
        [team1[4], team2[4], team3[4]],
        [team1[5], team2[5], team3[5]],
        [team1[6], team2[6], team3[6]],
      ];
    });
    print("done");
  }

  Future<List<String>> _fetchForm(String team) async {
    try {
      final sheet = await SheetsHelper.sheetSetup('NotesOrg'); // temporarily this sheet name.
      final column = 1;
      var columnData = await sheet?.values.column(column);

      var row = 1;
      for (int i = 0; i < columnData!.length; i++) {
        if (columnData[i] == team) {
          row = i + 1;
        }
      }
      List<String> stringList = [];
      var rowList = await sheet?.values.row(row);

      stringList = rowList!;

      return (stringList);
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  void update(PrimitiveWrapper variable, int inc) {
    setState(() {
      if ((variable.value + inc) >= 1 && (variable.value + inc) <= 5) {
        variable.value += inc;
      }
    });
  }

  void updateRelEff(String? newRanking) {
    setState(() {
      relEffectiveness = newRanking!;
    });
  }

  void updateSubjectiveNotes(int noteType, int teamIndex) {
    activeNoteType[teamIndex] = noteType;
    activeNoteControllers[teamIndex].text = noteMatrix[noteType][teamIndex];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Lead Scouts",
            ),
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
                  Text(
                    entries[0],
                    textScaleFactor: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                          width: width / 3.5, // Adjust the width as needed
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ScoreDisplay(
                                    effectiveness1.value, ("Effectiveness: ")),
                                CounterButton(
                                    update,
                                    effectiveness1,
                                    1,
                                    const Text(
                                      '+',
                                      textScaleFactor: 2,
                                    )),
                                CounterButton(
                                    update,
                                    effectiveness1,
                                    -1,
                                    const Text(
                                      '-',
                                      textScaleFactor: 2.5,
                                    )),
                              ])),
                      SizedBox(
                          width: width / 3.5, // Adjust the width as needed
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ScoreDisplay(
                                    effectiveness2.value, ("Effectiveness: ")),
                                CounterButton(
                                    update,
                                    effectiveness2,
                                    1,
                                    const Text(
                                      '+',
                                      textScaleFactor: 2,
                                    )),
                                CounterButton(
                                    update,
                                    effectiveness2,
                                    -1,
                                    const Text(
                                      '-',
                                      textScaleFactor: 2.5,
                                    )),
                              ])),
                      SizedBox(
                          width: width / 3.5, // Adjust the width as needed
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ScoreDisplay(
                                    effectiveness3.value, ("Effectiveness: ")),
                                CounterButton(
                                    update,
                                    effectiveness3,
                                    1,
                                    const Text(
                                      '+',
                                      textScaleFactor: 2,
                                    )),
                                CounterButton(
                                    update,
                                    effectiveness3,
                                    -1,
                                    const Text(
                                      '-',
                                      textScaleFactor: 2.5,
                                    )),
                              ])),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height / 3.5,
            child: Center(
              child: DropdownButtonFormField<String>(
                value: "1, 2, 3",
                onChanged: (String? value) {
                  updateRelEff(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Select an option',
                  border: OutlineInputBorder(),
                ),
                items: [
                  '1, 2, 3',
                  '1, 3, 2',
                  '2, 1, 3',
                  '2, 3, 1',
                  '3, 1, 2',
                  '3, 2, 1'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Text(value),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: height / 3.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    entries[2],
                    textScaleFactor: 1.5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            await setUp();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Fetched Notes")),
                            );
                          },
                          child: Icon(Icons.refresh, color: colors.myOnPrimary),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: width / 3.5,
                                child: DropdownButtonFormField<String>(
                                  value: "Auto Notes",
                                  onChanged: (String? newVal) {
                                    updateSubjectiveNotes(
                                        nameToInt[newVal]!, 0);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Select an option",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    "Auto Notes",
                                    "Accuracy",
                                    "Capabilities",
                                    "Trends",
                                    "Field Awareness",
                                    "Robot Failures",
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          //const Icon(Icons.star),
                                          //const SizedBox(width: 10),
                                          Text(value, textScaleFactor: 0.5),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width:
                                    width / 3.5, // Adjust the width as needed
                                child: TextField(
                                  controller: activeNote1,
                                  onChanged: (String value) {
                                    noteMatrix[activeNoteType[0]][0] = value;
                                  },
                                  maxLines:
                                      null, // Setting maxLines to null allows multiple lines
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: width / 3.5,
                                child: DropdownButtonFormField<String>(
                                  value: "Auto Notes",
                                  onChanged: (String? newVal) {
                                    updateSubjectiveNotes(
                                        nameToInt[newVal]!, 1);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Select an option",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    "Auto Notes",
                                    "Accuracy",
                                    "Capabilities",
                                    "Trends",
                                    "Field Awareness",
                                    "Robot Failures",
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          // const Icon(Icons.star),
                                          // const SizedBox(width: 10),
                                          Text(
                                            value,
                                            textScaleFactor: 0.5,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width:
                                    width / 3.5, // Adjust the width as needed
                                child: TextField(
                                  controller: activeNote2,
                                  onChanged: (String value) {
                                    noteMatrix[activeNoteType[1]][1] = value;
                                  },
                                  maxLines:
                                      null, // Setting maxLines to null allows multiple lines
                                ),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: width / 3.5,
                                child: DropdownButtonFormField<String>(
                                  value: "Auto Notes",
                                  onChanged: (String? newVal) {
                                    updateSubjectiveNotes(
                                        nameToInt[newVal]!, 2);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Select option",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: [
                                    "Auto Notes",
                                    "Accuracy",
                                    "Capabilities",
                                    "Trends",
                                    "Field Awareness",
                                    "Robot Failures",
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          // const Icon(Icons.star),
                                          // const SizedBox(width: 10),
                                          Text(
                                            value,
                                            textScaleFactor: 0.5,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width:
                                    width / 3.5, // Adjust the width as needed
                                child: TextField(
                                  controller: activeNote3,
                                  onChanged: (String value) {
                                    noteMatrix[activeNoteType[2]][2] = value;
                                  },
                                  maxLines:
                                      null, // Setting maxLines to null allows multiple lines
                                ),
                              ),
                            ]),
                      ])
                ],
              ),
            ),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () async {
              await _submitForm();
              reset();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Entrance(onThemeChanged: (newTheme) {
                            // Handle theme change here
                          })));
            },
            child: const Icon(Icons.send, color: colors.myOnPrimary),
          )
        ],
      )),
    );
  }
}

class CounterButton extends StatelessWidget {
  final Function func;
  final PrimitiveWrapper prim;
  final int inc;
  final Widget child;
  const CounterButton(this.func, this.prim, this.inc, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          func(prim, inc);
        },
        icon: child);
  }
}

class ScoreDisplay extends StatelessWidget {
  final int points;
  final String lable;
  const ScoreDisplay(this.points, this.lable, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          lable,
          textScaleFactor: 0.9,
        ),
        SizedBox(width: width / 40),
        FittedBox(
            child: Text("$points",
                textScaleFactor: 1.4,
                style: const TextStyle(color: colors.myOnPrimary))),
      ],
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
