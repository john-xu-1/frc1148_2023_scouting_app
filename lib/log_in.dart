import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/lead_scouting.dart';
//import 'package:frc1148_2023_scouting_app/auto_form.dart';
import 'draw_area.dart';
import 'auto_visualization.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final List<String> entries = <String>[
    'Enter assigned Letter',
    'Enter match # (ex: 5)',
  ];

  @override
  void initState() {
    super.initState();

    fetchTeamFromSheets();
    formatSheetsTeamsData();

  }
  

  Future<String> _fetchForm(column, row) async {
    try {
      final sheet = await SheetsHelper.sheetSetup('Scouting Assignment'); // Replace with your sheet name    

      // Writing data
      final cell = await sheet?.cells.cell(column: column, row: row);
      return (cell!.value);
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }



  String A = "";
  String B = "";
  String C = "";
  String D = "";
  String E = "";
  String F = "";

  Map<String, List<String>> scoutLists = <String, List<String>>{};


  String results = "";
  String id = "";
  String mnum = "";


  void fetchTeamFromSheets () async {
    A = (await _fetchForm(2,1));
    B = (await _fetchForm(2,2));
    C = (await _fetchForm(2,3));
    D = (await _fetchForm(2,5));
    E = (await _fetchForm(2,6));
    F = (await _fetchForm(2,7));
  }
  

  void formatSheetsTeamsData() { 
    scoutLists["a"] = A.split(', ').map((aList) => aList.trim()).toList();
    scoutLists["b"] = B.split(', ').map((bList) => bList.trim()).toList();
    scoutLists["c"] = C.split(', ').map((cList) => cList.trim()).toList();
    scoutLists["d"] = D.split(', ').map((dList) => dList.trim()).toList();
    scoutLists["e"] = E.split(', ').map((eList) => eList.trim()).toList();
    scoutLists["f"] = F.split(', ').map((fList) => fList.trim()).toList();
  }

  String updateResults() {
    //after the q number and identifier are input changes the identifier's value
    int index = int.parse(mnum);
    String result = "";
    if (index < 1 || id == "") {
      print ("invalid");
      return result; // Invalid index
    } 

    if (id =='X'||(id == 'x')){
      if (index <= scoutLists["a"]!.length && index <= scoutLists["b"]!.length && index <= scoutLists["c"]!.length ) {
        result = "${scoutLists["a"]![index - 1]}, ${scoutLists["b"]![index - 1]}, ${scoutLists["c"]![index - 1]}";
      }
    }
    else if (id =='Y'||(id == 'y')){
      if (index <= scoutLists["d"]!.length && index <= scoutLists["e"]!.length && index <= scoutLists["f"]!.length ) {
        result = "${scoutLists["d"]![index - 1]}, ${scoutLists["e"]![index - 1]}, ${scoutLists["f"]![index - 1]}";
      }
    }
    else{
      if (index <= scoutLists[id.toLowerCase()]!.length) {
      result = scoutLists[id.toLowerCase()]![index - 1];
    }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    formatSheetsTeamsData();
    if (scoutLists.isEmpty){
      return const SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 36, 36, 36),
          body: Center(
            child: Text("loading",style: TextStyle(color: Color.fromARGB(255, 224, 224, 224)),),
          )
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("match scouting log in",),
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
                    Text(entries[0],textScaleFactor: 1.5,),
                    SizedBox(
                      width: width /3,
                      child: TextField(
                        onChanged: (String value) {
                          setState(() {
                            id = value;
                          });
                        },
                        cursorColor: colors.myOnSurface,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height/3.5,
              //color: Colors.red[400],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(entries[1],textScaleFactor: 1.5,),
                    SizedBox(
                      width: width /3,
                      child: TextField(
                        //int.parse(value)
                        onChanged: (String value) {
                          setState(() {
                            mnum = value;
                          });
                        },
                        cursorColor: colors.myOnSurface,
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

                  if (results != ""){
                    final String out = "q$mnum $results";
                    if (id =='X'||(id == 'x') || (id =='Y')||(id == 'y') ){
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => LeadScouting(teamName: out)
                        )
                      );
                    }
                    else{
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => DrawArea(teamName: out)
                        )
                      );
                    }
                  }

              },
              child: const Icon(Icons.send),
            )
          ],
        )
      ),
    );
  }
}