import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/lead_scouting.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'sheets_helper.dart';
import 'return_team.dart' as rt;

SheetsHelper sh = SheetsHelper();

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
    
    fetcher();
  }



  String cellValueA = "";
  String cellValueB = "";
  String cellValueC = "";
  String cellValueD = "";
  String cellValueE = "";
  String cellValueF = "";


  

  Future<String> _fetchForm(column, row) async {
    try {
      final sheet = await sh.sheetSetup('Scouting Assignment'); // Replace with your sheet name    

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

  List<String> aList = List.empty();
  List<String> bList = List.empty();
  List<String> cList = List.empty();
  List<String> dList = List.empty();
  List<String> eList = List.empty();
  List<String> fList = List.empty();

  void fetcher () async {
    A = (await _fetchForm(2,1));
    B = (await _fetchForm(2,2));
    C = (await _fetchForm(2,3));
    D = (await _fetchForm(2,5));
    E = (await _fetchForm(2,6));
    F = (await _fetchForm(2,7));
  }
  

  void arraySorter( identifier ) { 

    if ((identifier == 'A')||(identifier == 'a')) {
      aList = A.split(', ').map((aList) => aList.trim()).toList();
    }
    else if ((identifier == 'B')||(identifier == 'b')) {
      
      bList = B.split(', ').map((bList) => bList.trim()).toList();
    }
    else if ((identifier == 'C')||(identifier == 'c')) {
      
      cList = C.split(', ').map((cList) => cList.trim()).toList();
    }
    else if ((identifier == 'D')||(identifier == 'd')) {
      
      dList = D.split(', ').map((dList) => dList.trim()).toList();
    }
    else if ((identifier == 'E')||(identifier == 'e')) {
      
      eList = E.split(', ').map((eList) => eList.trim()).toList();
    }
    if ((identifier == 'F')||(identifier == 'f')) {
      
      fList = F.split(', ').map((fList) => fList.trim()).toList();
    }
    else{
      aList = A.split(', ').map((aList) => aList.trim()).toList();
      bList = B.split(', ').map((bList) => bList.trim()).toList();
      cList = C.split(', ').map((cList) => cList.trim()).toList();
      dList = D.split(', ').map((dList) => dList.trim()).toList();
      eList = E.split(', ').map((eList) => eList.trim()).toList();
      fList = F.split(', ').map((fList) => fList.trim()).toList();
    }
   
    // A=['frc294', 'frc294', 'frc294', 'frc4999', 'frc2710', 'frc4501', 'frc4201', 'frc8898', 'frc3473', 'frc9172', 'frc4501', 'frc7611', 'frc4470', 'frc687', 'frc846', 'frc9172', 'frc4123', 'frc8600', 'frc6833', 'frc3408', 'frc597', 'frc687', 'frc1452', 'frc7185', 'frc2710', 'frc6833', 'frc1759', 'frc5199', 'frc1159', 'frc687', 'frc7611', 'frc4123', 'frc8020', 'frc1148', 'frc5669', 'frc6904', 'frc5124', 'frc5857', 'frc7185', 'frc1197', 'frc980', 'frc3952', 'frc9172', 'frc8600', 'frc5500', 'frc2584', 'frc8020', 'frc606', 'frc7185', 'frc7230', 'frc1661', 'frc3408', 'frc597', 'frc7611', 'frc980', 'frc846', 'frc3473', 'frc4470', 'frc6658', 'frc1515', 'frc606', 'frc8898', 'frc4201', 'frc5089', 'frc5669'];
    // B=['frc4123', 'frc4123', ' frc4123', ' frc3952', ' frc4470', ' frc5669', ' frc1197', ' frc1148', ' frc980', ' frc6000', ' frc5089', ' frc3863', ' frc2584', ' frc1452', ' frc702', ' frc1197', ' frc1148', ' frc1759', ' frc846', ' frc5857', ' frc2584', ' frc6904', ' frc3952', ' frc5500', ' frc8600', ' frc1148', ' frc5669', ' frc1661', ' frc6658', ' frc5089', ' frc2584', ' frc597', ' frc7185', ' frc2710', ' frc9172', ' frc4201', ' frc207', ' frc4964', ' frc3473', ' frc5500', ' frc1452', ' frc606', ' frc4964', ' frc702', ' frc5124', ' frc4501', ' frc207', ' frc687', ' frc980', ' frc1197', ' frc4123', ' frc5500', ' frc1452', ' frc5199', ' frc8898', ' frc4964', ' frc4201', ' frc294', ' frc5199', ' frc8020', ' frc6904', ' frc7230', ' frc2710', ' frc980', ' frc6000'];
    // C=[' frc1452', ' frc1452', ' frc1452', ' frc1759', ' frc687', ' frc5124', ' frc6658', ' frc1159', ' frc3408', ' frc6904', ' frc2710', ' frc606', ' frc8898', ' frc3408', ' frc5857', ' frc294', ' frc4964', ' frc1159', ' frc5124', ' frc4999', ' frc1197', ' frc1515', ' frc1159', ' frc606', ' frc7230', ' frc5500', ' frc5857', ' frc6833', ' frc702', ' frc4201', ' frc7230', ' frc4501', ' frc3863', ' frc5124', ' frc846', ' frc294', ' frc6000', ' frc597', ' frc7611', ' frc207', ' frc5199', ' frc8020', ' frc4999', ' frc5669', ' frc4123', ' frc1515', ' frc5199', ' frc2584', ' frc1759', ' frc4470', ' frc8600', ' frc6658', ' frc207', ' frc1515', ' frc3952', ' frc7230', ' frc1661', ' frc6658', ' frc4501', ' frc3408', ' frc702', ' frc7185', ' frc5500', ' frc4999', ' frc4964'];
    // D=['frc5199', 'frc5199', 'frc5199', 'frc1515', 'frc4964', 'frc5199', 'frc207', 'frc1452', 'frc7230', 'frc6833', 'frc5669', 'frc846', 'frc5199', 'frc4999', 'frc597', 'frc6658', 'frc702', 'frc5500', 'frc5669', 'frc3863', 'frc4470', 'frc1661', 'frc4964', 'frc294', 'frc8020', 'frc5089', 'frc207', 'frc6904', 'frc4999', 'frc6000', 'frc3952', 'frc1197', 'frc1452', 'frc606', 'frc8898', 'frc3408', 'frc6904', 'frc6833', 'frc3863', 'frc7230', 'frc2710', 'frc1148', 'frc294', 'frc3863', 'frc5857', 'frc6000', 'frc3473', 'frc8600', 'frc4201', 'frc6904', 'frc5089', 'frc702', 'frc6000', 'frc1159', 'frc5857', 'frc1759', 'frc2710', 'frc687', 'frc1661', 'frc5124', 'frc4501', 'frc1159', 'frc5199', 'frc2584', 'frc1197'];
    // E=[' frc6833', ' frc6833', ' frc6833', ' frc5669', ' frc6833', ' frc294', ' frc8600', ' frc2584', ' frc702', ' frc4123', ' frc7185', ' frc4201', ' frc5124', ' frc7230', ' frc2710', ' frc980', ' frc1515', ' frc3952', ' frc4201', ' frc5199', ' frc7611', ' frc702', ' frc6658', ' frc6000', ' frc4501', ' frc1159', ' frc3408', ' frc846', ' frc4470', ' frc3473', ' frc8600', ' frc1759', ' frc1515', ' frc207', ' frc687', ' frc1159', ' frc3863', ' frc6658', ' frc4501', ' frc1515', ' frc6000', ' frc1661', ' frc3408', ' frc1159', ' frc687', ' frc6658', ' frc597', ' frc7185', ' frc1148', ' frc8898', ' frc5124', ' frc6833', ' frc8020', ' frc606', ' frc7185', ' frc5089', ' frc4999', ' frc3863', ' frc8898', ' frc7611', ' frc5857', ' frc597', ' frc3952', ' frc3863', ' frc3473'];
    // F=[' frc687', ' frc687', ' frc687', ' frc4470', ' frc606', ' frc7185', ' frc5857', ' frc1661', ' frc3952', ' frc8020', ' frc597', ' frc207', ' frc5857', ' frc1661', ' frc294', ' frc8020', ' frc3473', ' frc6000', ' frc8898', ' frc5089', ' frc9172', ' frc980', ' frc3473', ' frc4123', ' frc1148', ' frc7611', ' frc9172', ' frc980', ' frc5124', ' frc8898', ' frc294', ' frc4964', ' frc5500', ' frc4999', ' frc702', ' frc2584', ' frc4964', ' frc8600', ' frc4470', ' frc4123', ' frc1759', ' frc5089', ' frc846', ' frc6833', ' frc7611', ' frc1452', ' frc3952', ' frc1197', ' frc606', ' frc2710', ' frc9172', ' frc4501', ' frc687', ' frc5669', ' frc6904', ' frc2584', ' frc1197', ' frc1148', ' frc8020', ' frc8600', ' frc1452', ' frc846', ' frc9172', ' frc4123', ' frc1148'];
  }

  void updateResults (String result){
    setState(() {
      results = result;
    });
  }

  void teamAsker (rt.ReturnTeam test){
    // print (id);
    // print (mnum);
    test.setIdentifier(id);
    test.setIndex(int.parse(mnum));
    // print( test.identifier);
    // print( test.index);
    arraySorter(id);
    test.setLists(aList,bList,cList,dList,eList,fList);
    results = test.setStringValue();
    print (results);
    updateResults(results);
  }

  String results = "";

  String id = "";
  String mnum = "";

  
   @override
  Widget build(BuildContext context) {
    var test =  rt.ReturnTeam(aList,bList,cList,dList,eList,fList);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                          id = value;
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
                      ),
                    ),
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
            ElevatedButton(
              onPressed: () {

                  teamAsker(test);
                  final String out = "q$mnum $results";
                  print (out);
                  if (id =='X'||(id == 'x') || (id =='Y')||(id == 'y') ){
                    print(test.b1.length);
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
                        builder: (context) => ScoutingForm(teamName: out)
                      )
                    );
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