import 'package:flutter/material.dart';
import 'team_display_instance.dart';
import 'sheets_helper.dart';

class TeamDataEntrance extends StatefulWidget {
  const TeamDataEntrance({super.key});

  @override
  State<TeamDataEntrance> createState() => _TeamDataEntranceState();
}

class _TeamDataEntranceState extends State<TeamDataEntrance> {
  List<String> allTeams = List.empty();
  List<String> selectedTeams = List.empty(growable: true);

  String selectedTeamsDisplay = "";
  
  List<String> teamDataNames = List.empty(growable: true);
  List<String> teamNotesNames = List.empty(growable: true);
  Map<String, Map<String, String>> teamsNumberDatas = {};
  Map<String, Map<String, String>> teamsNotesDatas = {};


  Future<void> _updateTeams() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("PowerRatings.py");

      allTeams = await sheet!.values.column(1);
      allTeams = allTeams.sublist(1);
      
      setState(() {});
      
    } catch (e) {
      print('Error: $e');
    }
  }


  

  @override
  void initState() {
    super.initState();
    
    
    _updateTeams();
  
  }

  Future<void> _updateTeamInfo(String team) async {
    final sheet = await SheetsHelper.sheetSetup("Team Data");

    await sheet!.values.insertRow(1, [team]);

    final rows = await sheet.values.allRows();

    List<String> dataNames = rows[0].sublist(1);
      
    teamDataNames = dataNames; 
    teamNotesNames = rows[2].sublist(1);

    List<String> dataNumbers = rows[1].sublist(1);
    List<String> dataNotes = rows[3].sublist(1);

    

    teamsNumberDatas.putIfAbsent(team, () => {});
    teamsNotesDatas.putIfAbsent(team, () => {});


    for (int i = 0; i < dataNames.length; i++)
    {
      // if (isNumeric( dataNumbers[i])){
      //   teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => dataNumbers[i]);
      // }
      teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => dataNumbers[i]);
      // else if (dataNumbers[i] == "true"){
      //   teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => 1);
      // }
      // else{
      //   teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => 0);
      // }
    }


    for (int i = 0; i < teamNotesNames.length; i++){
      if (i >= dataNotes.length){
        dataNotes.add("");
      }
      teamsNotesDatas[team]!.putIfAbsent(teamNotesNames[i], () => dataNotes[i]);
    }

    setState(() {
      
    });

    //print (teamsNumberDatas);
    print (teamsNotesDatas);

  }

  
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController teamDrop = TextEditingController();
    
    if (allTeams.isEmpty) {
      return const SafeArea(
        child: Scaffold(
            body: Center(
              child: Text(
                "loading ...",
              ),
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Team"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(selectedTeamsDisplay),
              DropdownMenu<String>(
                  width: width,
                  hintText: "Select Team",
                  requestFocusOnTap: true,
                  controller: teamDrop,
                  enableFilter: true,
                  label: const Text('Select Team'),
                  onSelected: (String? value) async {
                    // setState(() {
                    //   teamDrop.text = "";
                    // });
                    // if (!selectedTeams.contains(value)) {
          
                    //   setState(() {
                    //     selectedTeamsDisplay += "$value, ";
                    //     selectedTeams.add (value!);
                    //   });
                    // }
                    if (value != null){
                      if (!teamsNumberDatas.containsKey(value) || !teamsNotesDatas.containsKey(value)) {
                        await _updateTeamInfo(value!);
                      }
                      if (context.mounted){
                        Navigator.push(
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) => TeamDisplayInstance(
                              teamDataNames: teamDataNames, 
                              teamsNumberDatas: teamsNumberDatas, 
                              teamsNotesDatas: teamsNotesDatas, 
                              team: value!
                            )
                          )
                        );
                      }
                    }
                    
                    
                  },
                  dropdownMenuEntries:
                      allTeams.map<DropdownMenuEntry<String>>((String menu) {
                    return DropdownMenuEntry<String>(
                        value: menu,
                        label: menu,);
                  }).toList(),
              ),
              SizedBox(
                height: height * 0.75,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: selectedTeams.length,
                  itemBuilder: (BuildContext context, int index) {
                    print (selectedTeams);
                    return IconButton(
                      onPressed: () async {
                        if (!teamsNumberDatas.containsKey(selectedTeams[index]) || !teamsNotesDatas.containsKey(selectedTeams[index])) {
                          await _updateTeamInfo(selectedTeams[index]);
                        }
                        if (context.mounted){
                          Navigator.push(
                            context, 
                            MaterialPageRoute
                            (
                              builder: (context) => TeamDisplayInstance(
                                teamDataNames: teamDataNames, 
                                teamsNumberDatas: teamsNumberDatas, 
                                teamsNotesDatas: teamsNotesDatas, 
                                team: selectedTeams[index]
                              )
                            )
                          );
                        }
                        else{
                          print ("error");
                        }
                      },
                      icon: Row( children: [ const Icon(Icons.circle,), Text(selectedTeams[index]) ] ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider()
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            selectedTeams = List.empty(growable: true);
            selectedTeamsDisplay = "";
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
