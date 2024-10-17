
import 'package:frc1148_2023_scouting_app/team_graphing.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
import 'pit_scouting.dart';
//import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'package:flutter/material.dart';
import 'match_list.dart';
import 'auto_vis_drawer.dart';
import 'team_data_entrance.dart';
import 'auto_form.dart';

class Entrance extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const Entrance({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<Entrance> createState() => _Entrance();
}

bool isLight = false;

class _Entrance extends State<Entrance> {
  String pitTeam = "";

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selection Menu"),
        backgroundColor: colorScheme.primary,
      ),
      body: Center(
        child: Container(
          color: colorScheme.surface,
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         widget.onThemeChanged(ThemeMode.light);
              //       },
              //       icon: const Icon(Icons.light_mode),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         widget.onThemeChanged(ThemeMode.dark);
              //       },
              //       icon: const Icon(Icons.dark_mode),
              //     ),
              //   ],
              // ),
              _buildGridItem(
                context,
                icon: Icons.data_array,
                label: "Team Data",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeamDataEntrance(),
                    ),
                  );
                },
              ),
              _buildGridItem(
                context,
                icon: Icons.edit_document,
                label: "Match Scouts",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
              ),
              _buildGridItemWithInput(
                context,
                icon: Icons.question_mark,
                label: "Pit Scouts",
                pitTeam: pitTeam,
                onTeamChanged: (value) {
                  setState(() {
                    pitTeam = value;
                  });
                },
                onTap: () {
                  if (pitTeam.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PitScouting(teamName: pitTeam),
                      ),
                    );
                  }
                },
              ),
              _buildGridItem(
                context,
                icon: Icons.search,
                label: "Match List",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MatchList(),
                    ),
                  );
                },
              ),
              _buildGridItem(
                context,
                icon: Icons.data_usage,
                label: "Auto Path Visual",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RobotPathGraph(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            isLight = !isLight;
            if (isLight) {
              widget.onThemeChanged(ThemeMode.light);
            } else {
              widget.onThemeChanged(ThemeMode.dark);
            }
          });
        },
        child: const Icon(Icons.light_mode_outlined),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        color: colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 100,
            onPressed: onTap,
            icon: Icon(icon),
            color: colorScheme.onSurface,
          ),
          Text(
            label,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItemWithInput(BuildContext context,
      {required IconData icon,
      required String label,
      required String pitTeam,
      required ValueChanged<String> onTeamChanged,
      required VoidCallback onTap}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        color: colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 100,
            onPressed: onTap,
            icon: Icon(icon),
            color: colorScheme.onSurface,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Team #: ",
                style: TextStyle(color: colorScheme.onSurface),
              ),
              SizedBox(
                height: 25,
                width: 100,
                child: TextField(
                  onChanged: onTeamChanged,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.onSurface),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ],
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