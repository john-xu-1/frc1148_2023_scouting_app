
import 'package:frc1148_2023_scouting_app/team_display_choice.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
import 'pit_scouting.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'match_list.dart';
import 'auto_vis_drawer.dart';
import 'auto_form.dart';

class Entrance extends StatefulWidget {
  const Entrance({Key? key}) : super(key: key);

  @override
  State<Entrance> createState() => _Entrance();
}


class _Entrance extends State<Entrance> {

  String pitTeam = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection Menu"),
        backgroundColor: colors.myBackground,
      ),
      body: Center(
        child: Container(
          color: colors.myPrimaryColor,
          child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                //color: Color.fromARGB(20, 62, 62, 62)
                color: colors.myOnBackground
              ),
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 100,
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => const TeamDisplayChoice(),
                        )
                      );
                    },  
                    icon: const Icon(Icons.data_array),
                    color: Colors.black,
                  ),
                  const Text("Team Data"),
                ],
              )
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                //color: Color.fromARGB(20, 62, 62, 62)
                color: colors.myOnBackground
              ),
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 100,
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => const LogIn(),
                        )
                      );
                    },  
                    icon: const Icon(Icons.edit_document),
                    color: Colors.black,
                  ),
                  const Text("Match Scouts"),
                  
                ],
              )
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                //color: Color.fromARGB(20, 62, 62, 62)
                color: colors.myOnBackground
              ),
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 100,
                    onPressed: (){
                      if (pitTeam != ""){
                        Navigator.push(
                          context, 
                          MaterialPageRoute
                          (
                            builder: (context) => PitScouting(teamName: pitTeam)
                          )
                        );
                      }
                    },  
                    icon: const Icon(Icons.question_mark),
                    color: Colors.black,
                  ),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const Text("Team #: "),
                      SizedBox(
                        height: 25,
                        width: 100,
                        child: TextField(
                          onChanged: (String value){
                            setState(() {
                              pitTeam = value;
                            });
                          },
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text("Pit Scouts"),
                ],
              )
            ),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                //color: Color.fromARGB(20, 62, 62, 62)
                color: colors.myOnBackground
              ),
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 100,
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => const MatchList()
                        )
                      );
                    },  
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                  ),
                  const Text("Match List"),
                  
                  
                ],
              )
            ),

            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                //color: Color.fromARGB(20, 62, 62, 62)
                color: colors.myOnBackground
              ),
              //color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 100,
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => const RobotPathGraph()
                        )
                      );
                    },  
                    icon: const Icon(Icons.data_usage),
                    color: Colors.black,
                  ),
                  const Text("Auto Path Visual"),
                  
                  
                ],
              )
            ),
          ],

        ),
        
        )
        

      ),



    );
  }
}

class DataBlock extends StatelessWidget {
  const DataBlock({super.key, required this.category, required this.displayIcon});
  final String category;
  final Icon displayIcon;
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Container(
    //   decoration: ShapeDecoration(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(60.0),
    //     ),
    //     color: Color.fromARGB(20, 62, 62, 62)
    //   ),
    //   //color: Colors.grey,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       IconButton(
    //         iconSize: 100,
    //         onPressed: (){
    //           if (category == "Team Data"){
    //              Navigator.push(
    //                 context, 
    //                 MaterialPageRoute
    //                 (
    //                   builder: (context) => const team_display_choice(),
    //                 )
    //               );
    //           }
    //           else if (category == "Pit Scouting"){
    //               Navigator.push(
    //                 context, 
    //                 MaterialPageRoute
    //                 (
    //                   builder: (context) => const pit_scouting(),
    //                 )
    //               );
    //           }
    //           else if (category == "Notes"){

    //           }
    //           else{
    //             Navigator.push(
    //                 context, 
    //                 MaterialPageRoute
    //                 (
    //                   builder: (context) => const ScoutingForm(),
    //                 )
    //               );
    //           }
    //         }, 
    //         icon: displayIcon,
    //         color: Colors.black,
    //       ),
    //       Text(category),
    //     ],
    //   )
      
    // );
  }
}