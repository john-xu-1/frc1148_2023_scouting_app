import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';


List<ScoutingForm> sf = List.empty();

class TeamDisplayInstance extends StatefulWidget {
  const TeamDisplayInstance({super.key, required this.teamDataNames, required this.teamsNumberDatas, required this.team, });

  final String team;
  final List<String> teamDataNames;
  final Map<String, Map<String, double>> teamsNumberDatas;
  
  @override
  State<TeamDisplayInstance> createState() => _TeamDisplayInstanceState();
}

class _TeamDisplayInstanceState extends State<TeamDisplayInstance> {
  

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 30, 30, 30),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.teamDataNames.length,
        itemBuilder: (BuildContext context, int jndex) {
          return Container(
            color: colors.mySecondaryColor,
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text("${widget.teamDataNames[jndex]}: ${widget.teamsNumberDatas[widget.team]![widget.teamDataNames[jndex]]!}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),)
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10,),
      ),
    );
  }
}
