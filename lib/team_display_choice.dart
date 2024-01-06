
import 'package:flutter/material.dart';
import 'team_display_instance.dart';
import 'sheetsHelper.dart';

SheetsHelper sh = SheetsHelper();

class TeamDisplayChoice extends StatefulWidget {
  const TeamDisplayChoice({super.key});

  @override
  State<TeamDisplayChoice> createState() => _TeamDisplayChoiceState();
  
}

class _TeamDisplayChoiceState extends State<TeamDisplayChoice> {

  List<String> allTeams = List.empty();
  List<TeamDisplayInstance> allTeamDisplays = [];


  Future<void> _updateTeams() async {
    try {
      final sheet = await sh.sheetSetup("PowerRatings.py");

      allTeams = await sheet!.values.column(1);
      allTeams = allTeams.sublist(1);
      setState(() {
        for (int i = 0; i < allTeams.length; i++){
          allTeamDisplays.add(TeamDisplayInstance(teamID: allTeams[i]));
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