import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';

class MatchListDisplay extends StatefulWidget {
  const MatchListDisplay({super.key, required this.matchData, required this.matchID});
  final List<String> matchData;
  final String matchID;
  @override
  State<MatchListDisplay> createState() => _MatchListDisplayState();
}

class _MatchListDisplayState extends State<MatchListDisplay> {

  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
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
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(height: height/8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child:  Text("Blue Alliance: ",style: TextStyle(color: colors.myBlue))//make blue, Auto and match points are diff colors
                    ),
                    SizedBox(
                      child: Text(widget.matchData[0])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[1])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[2])
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Amp points: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Auto:")),
                          Text(widget.matchData[3],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Match:")),
                          Text(widget.matchData[4],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    const SizedBox(
                      child: Text("Speaker points: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Auto: ")),
                          Text(widget.matchData[5],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[6],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Tele: ")),
                          Text(widget.matchData[7],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[8],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Trap points: "),
                    ),
                    SizedBox(
                      child: Text(widget.matchData[9])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[10])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[11])
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Parking Status: "),
                    ),
                    SizedBox(
                      child: Text("center: " + widget.matchData[12])
                    ),
                    SizedBox(
                      child: Text("left: " + widget.matchData[13])
                    ),
                    SizedBox(
                      child: Text("right: " + widget.matchData[14])
                    ),
                  ]
                ),
                Container(height: height/8),
                Divider(),
                Container(height: height/8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Red Alliance: ",style: TextStyle(color: colors.myRed))
                    ),
                    SizedBox(
                      child: Text(widget.matchData[15])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[16])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[17])
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Amp points: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Auto:")),
                          Text(widget.matchData[18],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Match:")),
                          Text(widget.matchData[19],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Speaker points: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Auto: ")),
                          Text(widget.matchData[20],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[21],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("Tele: ")),
                          Text(widget.matchData[22],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[23],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Trap points: "),
                    ),
                    SizedBox(
                      child: Text(widget.matchData[24])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[25])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[26])
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Parking Status: "),
                    ),
                    SizedBox(
                      child: Text("center: " + widget.matchData[27])
                    ),
                    SizedBox(
                      child: Text("left: " + widget.matchData[28])
                    ),
                    SizedBox(
                      child: Text("right: " + widget.matchData[29])
                    ),
                  ]
                ),
              ]
            ),
          ]
        )
      )
    );
  }
}
/**
make a colum
 row off 3 blue teams
   row of 7         Amp points  / Auto / not / Auto / not/ Auto / not
   row of 7         Speaker points  / Auto / not / Auto / not/ Auto / not
   row of 4         Trap points  / Trap points  / Trap points
   row of 4         Parking Status  /  Parking Status  / Parking Status
 
 divider

 row of 3 red teams
   row of 7         Amp points  / Auto / not / Auto / not/ Auto / not
   row of 7         Speaker points  / Auto / not / Auto / not/ Auto / not
   row of 4         Trap points  / Trap points  / Trap points
   row of 4         Parking Status  /  Parking Status  / Parking Status

   make auto and not diff colors
   add in total points + winner
*/