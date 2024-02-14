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
                          Text(widget.matchData[3],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[4],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[6],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[7],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[8],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[9],style: TextStyle(color: colors.mySecondaryColor))
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
                          Text(widget.matchData[10],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[11],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[12],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[13],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[14],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[15],style: TextStyle(color: colors.mySecondaryColor))
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
                      child: Text(widget.matchData[16])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[17])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[18])
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
                      child: Text(widget.matchData[19])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[20])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[21])
                    ),
                  ]
                ),

                Divider(),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Red Alliance: ",style: TextStyle(color: colors.myRed))
                    ),
                    SizedBox(
                      child: Text(widget.matchData[22])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[13])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[24])
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
                          Text(widget.matchData[25],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[26],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[27],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[28],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[29],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[30],style: TextStyle(color: colors.mySecondaryColor))
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
                          Text(widget.matchData[31],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[32],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[33],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[34],style: TextStyle(color: colors.mySecondaryColor))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(widget.matchData[35],style: TextStyle(color: colors.myPrimaryColor)),
                          Text(widget.matchData[36],style: TextStyle(color: colors.mySecondaryColor))
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
                      child: Text(widget.matchData[37])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[39])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[39])
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
                      child: Text(widget.matchData[40])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[41])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[42])
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