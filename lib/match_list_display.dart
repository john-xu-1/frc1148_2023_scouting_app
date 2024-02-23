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
                Container(height: height/12),
                SizedBox(
                 child: Text("Winner: "+ widget.matchData[10])
                ),
                SizedBox(
                 child: Text("B coop?: "+ widget.matchData[11],style: TextStyle(color: colors.myBlue))
                ),
                SizedBox(
                 child: Text("R coop?: "+ widget.matchData[28],style: TextStyle(color: colors.myRed))
                ),
                
                Divider(),
                Container(height: height/12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child:  Text("Blue Alliance: ",style: TextStyle(color: colors.myBlue))//make blue, Auto and match points are diff colors
                    ),
                    SizedBox(
                      child: Text(widget.matchData[2])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[3])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[4])
                    ),
                  ]
                ),
                SizedBox(
                 child: Text("Blue RP: "+ widget.matchData[0])
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Amp pts: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("A:")),
                          Text(widget.matchData[13],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("T:")),
                          Text(widget.matchData[14],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    const SizedBox(
                      child: Text("Speaker pts: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("A: ")),
                          Text(widget.matchData[15],style: TextStyle(color: colors.myAmped)),
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("T: ")),
                          Text(widget.matchData[17],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[16],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     const SizedBox(
                //       child: Text("Trap points: "),
                //     ),
                //     SizedBox(
                //       child: Text("center: " +widget.matchData[18])
                //     ),
                //     SizedBox(
                //       child: Text("left: " + widget.matchData[19])
                //     ),
                //     SizedBox(
                //       child: Text("right: " + widget.matchData[20])
                //     ),
                //   ]
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Parking: "),
                    ),
                    SizedBox(
                      child: Text(widget.matchData[21])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[22])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[23])
                    ),
                  ]
                ),
                Container(height: height/70),
                SizedBox(
                  child: Text("Total pts: " + widget.matchData[1], style: TextStyle(color:colors.myBlue),)
                ),
                Container(height: height/12),
                Divider(),
                Container(height: height/12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Red Alliance: ",style: TextStyle(color: colors.myRed))
                    ),
                    SizedBox(
                      child: Text(widget.matchData[7])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[8])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[9])
                    ),
                  ]
                ),
                SizedBox(
                 child: Text("Red RP: "+ widget.matchData[5])
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Amp pts: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("A:")),
                          Text(widget.matchData[30],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("M:")),
                          Text(widget.matchData[31],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Speaker pts: "),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("A: ")),
                          Text(widget.matchData[32],style: TextStyle(color: colors.myAmped)),
                        ]
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(child:Text("T: ")),
                          Text(widget.matchData[34],style: TextStyle(color: colors.myAmped)),
                          SizedBox(child:Text(" | ")),
                          Text(widget.matchData[33],style: TextStyle(color: colors.myMatch))
                        ]
                      ),
                    ),
                  ]
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: <Widget>[
                //     const SizedBox(
                //       child: Text("Trap points: "),
                //     ),
                //     SizedBox(
                //       child: Text("center: " + widget.matchData[35])
                //     ),
                //     SizedBox(
                //       child: Text("left: " + widget.matchData[36])
                //     ),
                //     SizedBox(
                //       child: Text("right: " + widget.matchData[37])
                //     ),
                //   ]
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      child: Text("Parking: "),
                    ),
                    SizedBox(
                      child: Text(widget.matchData[38])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[39])
                    ),
                    SizedBox(
                      child: Text(widget.matchData[40])
                    ),
                  ]
                ),
                Container(height: height/70),
                SizedBox(
                  child: Text("Total pts: " + widget.matchData[6], style: TextStyle(color:colors.myRed))
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