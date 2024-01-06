import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/sheetsHelper.dart';

List<ScoutingForm> sf = List.empty();
SheetsHelper sh = SheetsHelper();

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
      final sheet = await sh.sheetSetup("TeamDisplay");

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

      final sheet = await sh.sheetSetup("TeamDisplay");

      // Writing data
      //final firstRow = [topScoreCone, midScoreCone, lowScoreCone, topScoreCube, midScoreCube, lowScoreCube, tryParkAuto, missedCube];
      //await sheet!.values.insertRowByKey (widget.teamName, firstRow, fromColumn: 2);
      // prints [index, letter, number, label]

      dataSet = (await sheet!.values.rowByKey(widget.teamID))!;
      dataSet = dataSet.sublist(1);
      setState(() {}); //referesh after successful fetch
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _getNames();
    _updateTeams();
  }

  @override
  Widget build(BuildContext context) {
    if (dataSet.isEmpty || dataNames.isEmpty) {
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
          title: Text(widget.teamID),
        ),
        body: Center(
            child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: dataSet.length,
          itemBuilder: (BuildContext context, int index) {
            return DataBlock(category: dataNames[index], data: dataSet[index]);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ))

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
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            color: Colors.amber,
            child: Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$category: "),
                    Text(data),
                  ],
                ),
                const Divider(),
              ],
            )));
  }
}
