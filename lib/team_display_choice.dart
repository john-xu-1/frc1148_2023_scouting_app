import 'package:flutter/material.dart';
import 'team_display_instance.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'sheets_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class TeamDisplayChoice extends StatefulWidget {
  const TeamDisplayChoice({super.key});

  @override
  State<TeamDisplayChoice> createState() => _TeamDisplayChoiceState();
}

class _TeamDisplayChoiceState extends State<TeamDisplayChoice> {
  List<String> allTeams = List.empty();
  List<String> selectedTeams = List.empty(growable: true);

  String selectedTeamsDisplay = "";
  List<Widget> allTeamColorsDisplay = List.empty(growable: true);

  Map<String, Color> allTeamColors = {};

  String selectedMetric = "";
  List<LineChartBarData> coordinates = List.empty(growable: true);

  
  List<String> allMetricsName = List.empty(growable: true);
  
  List<String> teamDataNames = List.empty(growable: true);
  Map<String, Map<String, double>> teamsNumberDatas = {};
  Map<String, Map<String, List<String>>> teamsNotesDatas = {};


  Future<void> _updateTeams() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("PowerRatings.py");

      allTeams = await sheet!.values.column(1);
      allTeams = allTeams.sublist(1);
      for (int i = 0; i < allTeams.length; i++){
        allTeamColors[allTeams[i]] = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      }
      print (allTeamColors);
      setState(() {});
      print(allTeams.length);
    } catch (e) {
      print('Error: $e');
    }
  }


  Map<String, List<Map<String, List<int>>>> all = {};

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }


  Future<void> _updateGraphs() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("App results");

      final rows = await sheet!.values.allRows();
      
      allMetricsName = rows[0];

      for (int k = 0; k < allTeams.length; k++){
        List<Map<String, List<int>>> rutro = List.empty(growable: true);
        print ("got");
        for (int i = 1; i < rows.length; i++){ 

          int spaceLoc = rows[i][0].indexOf(" ");
          String teamNumber = rows[i][0].substring(spaceLoc+4);
          String matchNumber = rows[i][0].substring(1, spaceLoc);
          if (teamNumber == allTeams[k]){

            final allMetricsInAMatch = rows[i];

            Map<String, List<int>> aMatch = {};

            for (int j = 2; j < allMetricsInAMatch.length; j++){
              if (isNumeric( allMetricsInAMatch[j])){
                
                String columnName = allMetricsName[j];
                //if (allMetricsInAMatch)
                List<int> coordinate = [int.parse(matchNumber), int.parse(allMetricsInAMatch[j])];
                if (aMatch.containsKey(columnName)) {
                  aMatch.update(columnName, (value) => coordinate);
                } else {
                  aMatch.putIfAbsent(columnName, () => coordinate);
                }
              }
              
            }
            rutro.add( aMatch);
          }
        }
        if (all.containsKey(allTeams[k])) {
          print ("here");
          all.update(allTeams[k], (value) => rutro);
        } else {
          print ("here");
          all.putIfAbsent(allTeams[k], () => rutro);
        }
      }
      setState(() {}); 
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    all = {};
    _updateTeams();
    setState(() {
      _updateGraphs();
    });
  }

  Future<void> _updateTeamInfo(String team) async {
    final sheet = await SheetsHelper.sheetSetup("Team Data");

    await sheet!.values.insertRow(1, [team]);

    final rows = await sheet!.values.allRows();

    List<String> dataNames = rows[0].sublist(1);
      
    teamDataNames = dataNames; 
    List<String> dataNumbers = rows[1].sublist(1);

    teamsNumberDatas.putIfAbsent(team, () => {});


    for (int i = 0; i < dataNames.length; i++)
    {
      if (isNumeric( dataNumbers[i])){
        teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => double.parse(dataNumbers[i]));
      }
      else{
        teamsNumberDatas[team]!.putIfAbsent(dataNames[i], () => 0);
      }
    }

    setState(() {
      
    });

    print (teamsNumberDatas);

  }

  
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController teamDrop = TextEditingController();
    TextEditingController metricDrop = TextEditingController();

    //_updateTeamInfo("9442");
    
    if (allTeams.isEmpty || all.isEmpty) {
      return const SafeArea(
        child: Scaffold(
            backgroundColor: colors.myBackground,
            body: Center(
              child: Text(
                "loading ...",
                style: TextStyle(color: colors.myOnPrimary),
              ),
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(selectedTeamsDisplay),
              Row(mainAxisAlignment: MainAxisAlignment.center ,children: allTeamColorsDisplay,),
              Text(selectedMetric),
              DropdownMenu<String>(
                  width: width,
                  hintText: "Select Teams To Compare",
                  requestFocusOnTap: true,
                  controller: teamDrop,
                  enableFilter: true,
                  label: const Text('Select Teams To Compare'),
                  onSelected: (String? value) {
                    // setState(() {
                    //   teamDrop.text = "";
                    // });
                    if (!selectedTeams.contains(value)) {
          
                      setState(() {
                        selectedTeamsDisplay += "$value, ";
                        selectedTeams.add (value!);
                        allTeamColorsDisplay.add(Icon(Icons.circle, color: allTeamColors[value],));
                        allTeamColorsDisplay.add(const SizedBox(width: 10,),);
                      });
          
                      if (selectedMetric != ""){
                        LineChartBarData line;
                        print (all[value]);
                        List<FlSpot> spots = List.empty(growable: true);
                        for (int j = 0; j < all[value]!.length; j++){
                          FlSpot spot = FlSpot(all[value]![j][selectedMetric!]![0] as double, all[value]![j][selectedMetric!]![1] as double);
                          spots.add(spot);
                          
                        }
                        line = LineChartBarData(spots: spots, color: allTeamColors[value]);
                        //print (line);
                        setState(() {
                          coordinates.add(line);
                        });
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
              DropdownMenu<String>(
                  width: width,
                  hintText: "Select Metrics to Compare",
                  requestFocusOnTap: true,
                  controller: metricDrop,
                  enableFilter: true,
                  label: const Text('Select Metrics to Compare'),
                  onSelected: (String? value) {
                    //coordinates = List.empty(growable: true);
                    // setState(() {
                    //   metricDrop.text = "";
                    // });
                    selectedMetric = value!;
                    coordinates = List.empty(growable: true);
                    try{
                      for (int i = 0; i < selectedTeams.length; i++){
                        LineChartBarData line;
                        print (all[selectedTeams[i]]);
                        List<FlSpot> spots = List.empty(growable: true);
                        for (int j = 0; j < all[selectedTeams[i]]!.length; j++){
                          if (all[selectedTeams[i]]![j][value!] != null){
                            FlSpot spot = FlSpot(all[selectedTeams[i]]![j][value!]![0] as double, all[selectedTeams[i]]![j][value!]![1] as double);
                            spots.add(spot);
                          }
                          
                        }
                        line = LineChartBarData(spots: spots, color: allTeamColors[selectedTeams[i]]);
                        //print (line);
                        setState(() {
                          coordinates.add(line);
                        });
                      }
                    }
                    catch(e){
                      print (e);
                    }
                    
                  },
                  dropdownMenuEntries:
                      allMetricsName.sublist(2).map<DropdownMenuEntry<String>>((String menu) {
                    return DropdownMenuEntry<String>(
                        value: menu,
                        label: menu,);
                  }).toList(),
              ),
              coordinates.isNotEmpty ? 
              SizedBox(
                height: height*0.5,
                width: width,
                child: LineChart(
                  LineChartData(
                    lineBarsData: coordinates,
                  ),
                ),
              )
              : const SizedBox(),
              SizedBox(
                height: height * 0.75,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: selectedTeams.length,
                  itemBuilder: (BuildContext context, int index) 
                  {
                    print (selectedTeams);
                    if (!teamsNumberDatas.containsKey(selectedTeams[index])) _updateTeamInfo(selectedTeams[index]);
                    return IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) => TeamDisplayInstance(teamDataNames: teamDataNames, teamsNumberDatas: teamsNumberDatas, team: selectedTeams[index])
                          )
                        );
                      },
                      //color: allTeamColors[selectedTeams[index]],
                      icon: Row( children: [ Icon(Icons.circle, color: allTeamColors[selectedTeams[index]]), Text(selectedTeams[index]) ] ),
                    );
                    //TeamDisplayInstance(teamDataNames: teamDataNames, teamsNumberDatas: teamsNumberDatas, team: selectedTeams[index]);
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
            allTeamColorsDisplay = List.empty(growable: true);
            selectedMetric = "";
            coordinates = List.empty(growable: true);
          });
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
