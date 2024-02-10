import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/sheets_helper.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';

class MatchListDisplay extends StatefulWidget {
  const MatchListDisplay({super.key, required this.matchID});
  final String matchID;
  @override
  State<MatchListDisplay> createState() => _MatchListDisplayState();
}

class _MatchListDisplayState extends State<MatchListDisplay> {
  List<String> dataSet = List.empty();
  List<String> dataNames = List.empty();

  Future<void> _getNames() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("TBA-data");

      dataNames = await sheet!.values.row(1);
      dataNames = dataNames.sublist(1);
      setState(() {}); //referesh after successful fetch
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updateTeams() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("TBA-data");

      dataSet = (await sheet!.values.rowByKey(widget.matchID))!;
      dataSet = dataSet.sublist(1);
      setState(() {}); //referesh after successful fetch
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar( 
        title: Column(
          children: [
            const Text ("Matches",),
            Text(widget.matchID),
          ],
        ),
      ),
      body: Center(
      child: ListView(

//**
//make a colum
//  blue teams
//    row of 7         Amp points       Auto / not x3 [make auto vs match different colors]
//    row of 7         Speaker points   Auto / not x3
//    row of 4         Trap points      x3
//    row of 4         Parking Status   x3
//  
//  divider

//  red teams
//    row of 7         Amp points       Auto / not x3 [make auto vs match different colors]
//    row of 7         Speaker points   Auto / not x3
//    row of 4         Trap points      x3
//    row of 4         Parking Status   x3
//*/



      )
      )
    );
  }
}
