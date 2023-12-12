
import 'package:flutter/material.dart';
import 'team_display_instance.dart';
import 'sheetsHelper.dart';

SheetsHelper sh = SheetsHelper();

class team_display_choice extends StatefulWidget {
  const team_display_choice({super.key});

  @override
  State<team_display_choice> createState() => _team_display_choiceState();
  
}

class _team_display_choiceState extends State<team_display_choice> {

  // void _incrementCounter() {
  //   setState(() {
      

  //   });
  // }
  //int currentPageIndex = 0;

  // void navigateToPage(Widget page) {
  //   setState(() {
  //     pages.add(page);
  //     currentPageIndex = pages.length - 1;
  //   });
  // }

  // void returnToPreviousPage() {
  //   if (currentPageIndex > 0) {
  //     setState(() {
  //       currentPageIndex--;
  //     });
  //   }
  // }

  // void createForm (int ind){
  //   setState(() {
      
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute
  //       (
  //         builder: (context) => entryObjects[ind]
  //       )
  //     );

  //   });
  // }


  
  List<String> allTeams = List.empty();
  List<team_display_instance> allTeamDisplays = [];


  Future<void> _updateTeams() async {
    try {
      // final gsheets = GSheets(_creds);
      // final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      // final sheet = ss.worksheetByTitle('PowerRatings.py');     

      final sheet = await sh.sheetSetup("PowerRatings.py");

      // Writing data
      //final firstRow = [topScoreCone, midScoreCone, lowScoreCone, topScoreCube, midScoreCube, lowScoreCube, tryParkAuto, missedCube];
      //await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]
      allTeams = await sheet!.values.column(1);
      allTeams = allTeams.sublist(1);
      setState(() {
        for (int i = 0; i < allTeams.length; i++){
          allTeamDisplays.add(team_display_instance(teamID: allTeams[i]));
        }
      }); //referesh after successful fetch
      print (allTeams.length);
      print (allTeamDisplays.length);

    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  void initState() {
    super.initState();

      _updateTeams();
  }
  

  @override
  Widget build(BuildContext context) {
    if (allTeams.isEmpty){
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
        title: const Text("Home"),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: allTeams.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return Container(
              height: 50,
              color: Colors.grey[850],
              child: Center(
                child: ElevatedButton(
                  child: Text(allTeams[index]),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => allTeamDisplays[index]
                      )
                    );
                  }
                )
              )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}