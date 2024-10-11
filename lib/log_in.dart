import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/lead_scouting.dart';
//import 'package:frc1148_2023_scouting_app/auto_form.dart';
import 'draw_area.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final List<String> entries = <String>[
    'Enter your name',
    'Enter match # (ex: 5)',
  ];

  @override
  void initState() {
    super.initState();

    fetchTeamFromSheets();
    formatSheetsTeamsData();
  }

  Future<String> _fetchForm(column, row, sheetName) async {
    try {
      final sheet = await SheetsHelper.sheetSetup(
          sheetName); // Replace with your sheet name

      // Writing data
      final cell = await sheet?.cells.cell(column: column, row: row);
      return (cell!.value);
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }

  Future<void> _submitName(teamName) async {
    try {
      final sheet = await SheetsHelper.sheetSetup("App results");
      final scoutName = [name];
      await sheet!.values.insertRowByKey(teamName, scoutName, fromColumn: 19);
    } catch (e) {
      print('Error: $e');
    }
  }

  String A = "";
  String B = "";
  String C = "";
  String D = "";
  String E = "";
  String F = "";
  String namesString = "";
  String idsString = "";
  Map<String, String> nameToID = {
    "x": "x",
    "y": "y",
  };

  Map<String, List<String>> scoutLists = <String, List<String>>{};

  String results = "";
  String name = "";
  String mnum = "";

  void fetchTeamFromSheets() async {
    A = (await _fetchForm(2, 1, "Scouting Assignment"));
    B = (await _fetchForm(2, 2, "Scouting Assignment"));
    C = (await _fetchForm(2, 3, "Scouting Assignment"));
    D = (await _fetchForm(2, 5, "Scouting Assignment"));
    E = (await _fetchForm(2, 6, "Scouting Assignment"));
    F = (await _fetchForm(2, 7, "Scouting Assignment"));
    namesString = (await _fetchForm(5, 1, "Name To Bot Assign"));
    idsString = (await _fetchForm(5, 2, "Name To Bot Assign"));
    // print(namesString);
    // print(idsString);
  }

  void formatSheetsTeamsData() {
    scoutLists["a"] = A.split(', ').map((aList) => aList.trim()).toList();
    scoutLists["b"] = B.split(', ').map((bList) => bList.trim()).toList();
    scoutLists["c"] = C.split(', ').map((cList) => cList.trim()).toList();
    scoutLists["d"] = D.split(', ').map((dList) => dList.trim()).toList();
    scoutLists["e"] = E.split(', ').map((eList) => eList.trim()).toList();
    scoutLists["f"] = F.split(', ').map((fList) => fList.trim()).toList();

    List<String> nameList = namesString
        .split(", ")
        .map((name) => name.toLowerCase().replaceAll(" ", ""))
        .toList();
    List<String> idList = idsString
        .split(", ")
        .map((id) => id.toLowerCase().replaceAll(" ", ""))
        .toList();

    if (nameList.length != idList.length) {
      print(
          "name list and id list are not same size on google sheets, pls check");
    }
    String correspondingID;
    for (int i = 0; i < nameList.length; i++) {
      if (i < idList.length) {
        correspondingID = idList[i];
      } else {
        correspondingID = "z";
      }
      nameToID.update(nameList[i], (correspondingID) => correspondingID,
          ifAbsent: () => correspondingID);
    }
    // print(nameToID);
  }

  String updateResults() {
    //after the q number and identifier are input changes the identifier's value
    int index = int.parse(mnum);
    String id = nameToID[name]!;
    String result = "";
    if (index < 1 || id == "") {
      print("invalid");
      return result; // Invalid index
    }

    if (id == 'x') {
      if (index <= scoutLists["a"]!.length &&
          index <= scoutLists["b"]!.length &&
          index <= scoutLists["c"]!.length) {
        result =
            "${scoutLists["a"]![index - 1]}, ${scoutLists["b"]![index - 1]}, ${scoutLists["c"]![index - 1]}";
      }
    } else if (id == 'y') {
      if (index <= scoutLists["d"]!.length &&
          index <= scoutLists["e"]!.length &&
          index <= scoutLists["f"]!.length) {
        result =
            "${scoutLists["d"]![index - 1]}, ${scoutLists["e"]![index - 1]}, ${scoutLists["f"]![index - 1]}";
      }
    } else {
      if (index <= scoutLists[id]!.length) {
        result = scoutLists[id]![index - 1];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    formatSheetsTeamsData();
    if (scoutLists.isEmpty) {
      return const SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 36, 36, 36),
            body: Center(
              child: Text(
                "loading",
                style: TextStyle(color: Color.fromARGB(255, 224, 224, 224)),
              ),
            )),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "match scouting log in",
        ),
        elevation: 21,
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: height / 3.5,
            //color: Colors.red[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    entries[0],
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    width: width / 3,
                    child: TextField(
                      onChanged: (String value) {
                        setState(() {
                          name = value
                              .toLowerCase()
                              .replaceAll(" ", "")
                              .replaceAll(".", "");
                        });
                      },
                      cursorColor: colors.myOnSurface,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height / 3.5,
            //color: Colors.red[400],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    entries[1],
                    textScaleFactor: 1.5,
                  ),
                  SizedBox(
                    width: width / 3,
                    child: TextField(
                      //int.parse(value)
                      onChanged: (String value) {
                        setState(() {
                          mnum = value;
                        });
                      },
                      cursorColor: colors.myOnSurface,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                results = updateResults();
              });

              if (results != "") {
                final String out = "q$mnum $results";
                if (name == ('x') || name == ('y')) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeadScouting(teamName: out)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DrawArea(
                                teamName: out,
                                id: nameToID[name]!,
                              )));
                  _submitName(out);
                }
              }
            },
            child: const Icon(Icons.send, color: colors.myOnPrimary),
          )
        ],
      )),
    );
  }
}
