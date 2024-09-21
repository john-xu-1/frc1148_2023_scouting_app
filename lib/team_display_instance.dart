import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/sheets_helper.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';


import 'package:fl_chart/fl_chart.dart';

List<ScoutingForm> sf = List.empty();

class TeamDisplayInstance extends StatefulWidget {
  const TeamDisplayInstance({super.key, required this.teamID});
  final String teamID;
  @override
  State<TeamDisplayInstance> createState() => _TeamDisplayInstanceState();
}

class _TeamDisplayInstanceState extends State<TeamDisplayInstance> {
  List<String> dataSet = List.empty();
  List<String> dataNames = List.empty();

  Future<void> _getNames() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("TeamDisplay");

      dataNames = await sheet!.values.row(1);
      dataNames = dataNames.sublist(1);
      setState(() {}); //referesh after successful fetch
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateTeams() async {
    try {
      // final gsheets = GSheets(_creds);
      // final ss = await gsheets.spreadsheet('1C4_kygqZTOo3uue3eBxrMV9b_3UJVuDiOVZqAeGHvzE');
      // final sheet = ss.worksheetByTitle('TeamDisplay');

      final sheet = await SheetsHelper.sheetSetup("TeamDisplay");

      // Writing data
      //final firstRow = [topScoreCone, midScoreCone, lowScoreCone, topScoreCube, midScoreCube, lowScoreCube, tryParkAuto, missedCube];
      //await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]

      dataSet = (await sheet!.values.rowByKey(widget.teamID))!;
      dataSet = dataSet.sublist(0);
      setState(() {}); //referesh after successful fetch
    } catch (e) {
      print('Error: $e');
    }
  }

  //HashMap<String, List<int>> rutro = HashMap();
  List<Map<String, List<int>>> rutro = List.empty(growable: true);


  Future<void> _updateGraphs() async {
    try {

      final sheet = await SheetsHelper.sheetSetup("App results");

      final rows = await sheet!.values.allRows();
      
      final allMetricsName = rows[0];

      for (int i = 1; i < rows.length; i++){ 
        int spaceLoc = rows[i][0].indexOf(" ");
        String teamNumber = rows[i][0].substring(spaceLoc+4);
        String matchNumber = rows[i][0].substring(1, spaceLoc);

        if (teamNumber == widget.teamID){
          final allMetricsInAMatch = rows[i];
          
          //List<List<int>>> coordinates = List.empty(growable: true);

          Map<String, List<int>> aMatch = {};

          for (int j = 2; j < allMetricsInAMatch.length; j++){
            //sus
            
            if (allMetricsInAMatch[j] != "true" && allMetricsInAMatch[j] != "false"){
              
              String columnName = allMetricsName[j];
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

      //print (rutro);

      // dataSet = (await sheet!.values.rowByKey(widget.teamID))!;
      // dataSet = dataSet.sublist(0);
      setState(() {}); 
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _getNames();
    _updateTeams();
    _updateGraphs();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<FlSpot> coordinates = List.empty(growable: true);
    String selected = "Amp Points";
    for (int i = 0; i < rutro.length; i++){
      FlSpot spot = FlSpot(rutro[i][selected]![0] as double, rutro[i][selected]![1] as double);
      coordinates.add(spot);
    }
    
    print (coordinates);
    if (dataSet.isEmpty || dataNames.isEmpty) {
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
          title: Text(widget.teamID),
        ),
        body: Center(
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: coordinates
                )
              ]
            ),

          )
        )
        // body: Center(
        //   child: ListView.separated(
        //     padding: const EdgeInsets.all(8),
        //     itemCount: dataSet.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return DataBlock(category: dataNames[index], data: dataSet[index]);
        //   },
        //   separatorBuilder: (BuildContext context, int index) =>
        //     Container(
        //       alignment: AlignmentDirectional.center,
        //       height: height / 150,
        //     ),
        //   )
        // )

        // Column(
        //   children: [
        //     DataBlock(category: "driving speed", data: dataSet[0]),
        //     DataBlock(category: "meow", data: dataSet[1]),
        //   ]
        // ),

    );
  }
}

class DataBlock extends StatelessWidget {
  const DataBlock({super.key, required this.category, required this.data});
  final String category;
  final String data;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height/13,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            //color: Color.fromRGBO(86, 14, 12, 0.982)),
            //color: Color.fromARGB(255, 45, 44, 44)),
            color: colors.myOnBackgroundD),
          child: Column(
            children: [
              //const Divider(),
              SizedBox(
                height: height/45,
                width: width,
              ),
              Container(
                //color: Color.fromARGB(255, 192, 180, 180),
                width:width/2,
                decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  //color: Color.fromARGB(255, 204, 191, 191),),
                  color: colors.myPrimaryColor,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$category: ",textScaleFactor: 1.5,style: TextStyle(color: colors.myOnPrimary)),
                      if (data==("true"))
                        Icon(Icons.check)
                        else if (data==("false"))
                        Icon(Icons.close)
                        else
                      Text(data,textScaleFactor: 1.5,style: TextStyle( color: const Color.fromARGB(255, 12, 11, 11))),
                    ],
                ),
              ),
            ],
          )
        )
      );
  }
}
