import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';


List<ScoutingForm> sf = List.empty();

class TeamDisplayInstance extends StatefulWidget {
  const TeamDisplayInstance({super.key, required this.teamDataNames, required this.teamsNumberDatas, required this.team, });

  final String team;
  final List<String> teamDataNames;
  final Map<String, Map<String, String>> teamsNumberDatas;
  
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: Text(widget.team)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                height: height*0.3,
                child: GridView.count(
                  crossAxisCount: 4,
                  //padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Ground Intake", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20), textScaler: TextScaler.linear(0.5)),
                            widget.teamsNumberDatas[widget.team]!["intake form ground"] == 0 ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Source Intake", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20), textScaler: TextScaler.linear(0.5)),
                            widget.teamsNumberDatas[widget.team]!["intake from source"] == 0 ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Speaker", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["speaker?"] == 0 ? Icon(Icons.cancel_outlined) : Icon(Icons.check),
                            Text(widget.teamsNumberDatas[widget.team]!["how they speaker"]!),
                          ],
                        ),
                      ),
                    ),
                    Container(
                     decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Amp", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["amp?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Climb", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["climb?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Trap", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["trap?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: colors.myPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Stage", style: TextStyle(color: colors.mySecondaryColor, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["under Stage?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Weight: "),
                              Text(widget.teamsNumberDatas[widget.team]!["Weight"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Drive: "),
                              Text(widget.teamsNumberDatas[widget.team]!["drive type"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Intake: "),
                              Text(widget.teamsNumberDatas[widget.team]!["intake type"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Speed: "),
                              Text(widget.teamsNumberDatas[widget.team]!["robot speed"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("drive quality"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Bumper quality: "),
                              Text(widget.teamsNumberDatas[widget.team]!["bumper quality(1-5)"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: colors.myPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Motor Num: "),
                              Text(widget.teamsNumberDatas[widget.team]!["number of motors"]!
                              , style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
          
          
          
          
              
              Container(
                width: width,
                height: height*0.3,
                color: Colors.grey,//colors.myOnBackground,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Score", style: TextStyle(color: colors.mySecondaryColor, fontSize: 35),),
                          const Text("NA", style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("Average",),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["OPR"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("OPR",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Notes", style: TextStyle(color: colors.mySecondaryColor, fontSize: 35),),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Notes"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("Average",),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Amps per Game"]!).round() + double.parse(widget.teamsNumberDatas[widget.team]!["Speaker per Game"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("OPR",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Pass", style: TextStyle(color: colors.mySecondaryColor, fontSize: 35),),
                          Text("need", style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("Average",),
                          const Text("NA", style: TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("OPR",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Speaker", style: TextStyle(color: colors.mySecondaryColor, fontSize: 35),),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Speaker"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("Average",),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Speaker per Game"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("OPR",),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Amp", style: TextStyle(color: colors.mySecondaryColor, fontSize: 35),),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Amp"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("Average",),
                          Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Amps per Game"]!).round()}", style: const TextStyle(color: colors.myPrimaryColor, fontSize: 20),),
                          const Text("OPR",),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
