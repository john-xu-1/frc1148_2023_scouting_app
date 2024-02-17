import 'package:flutter/material.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';
import 'match_list_display.dart';

class MatchList extends StatefulWidget {
  const MatchList({Key? key}) : super(key: key);
  @override
  State<MatchList> createState() => _MatchList();
}

class _MatchList extends State<MatchList> {
  


  @override
  void initState() {
    super.initState();


  }

  List<String> matches = List.empty(growable: true);
  

  Future<void> _fillMatches(col) async {
    try {
      final sheet = await SheetsHelper.sheetSetup('TBA-data');

      final cell = await sheet?.cells.column(col);
      for (int i = 0; i < cell!.length; i++){
        matches.add(cell[i].value);
      }
      setState(() {
        
      });
      
    } catch (e) {
      print('Error: $e');
    }
  }
    
  Future<List<String>> _fetchRow(String matchID) async {
    try {
      final sheet = await SheetsHelper.sheetSetup('TBA-data');

      final cell = await sheet!.values.rowByKey (matchID);

      List<String> out = List.empty(growable: true);
      for (int i = 0; i < cell!.length; i++){
        out.add ( cell[i] );
      }
      
      return out;
      
    } catch (e) {
      print('Error: $e');
      return List.empty();
    }
  }




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: matches.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: colors.myOnBackgroundD,),
              child: Row(
                children: [
                  SizedBox(
                    height: height / 12,
                    width: width / 10,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: Text(matches[index]),
                        onPressed: () async {
                          List<String> matchData = await _fetchRow(matches[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute( builder: (context) =>  MatchListDisplay (matchData: matchData, matchID: matches[index]) )
                          );
                        }
                      )
                    )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Container(
            alignment: AlignmentDirectional.center,
            height: height / 150,
          ),
      ),



      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () async {
          await _fillMatches(1);
        }
      ),
    );


  }
}