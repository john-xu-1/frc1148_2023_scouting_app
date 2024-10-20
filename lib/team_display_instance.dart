import 'auto_vis_drawer.dart';
import 'package:frc1148_2023_scouting_app/team_graphing.dart';

import 'sheets_helper.dart';
import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';


List<ScoutingForm> sf = List.empty();

class TeamDisplayInstance extends StatefulWidget {
  const TeamDisplayInstance({super.key, required this.teamDataNames, required this.teamsNumberDatas, required this.team, required this.teamsNotesDatas, });

  final String team;
  final List<String> teamDataNames;
  final Map<String, Map<String, String>> teamsNumberDatas;
  final Map<String, Map<String, String>> teamsNotesDatas;
  
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team),
        backgroundColor: colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: Text("Capabilities", style: TextStyle(color: colors.myOnPrimary, fontSize: 35), ),),
              ),


              SizedBox(
                width: width,
                height: height*0.3,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Ground\nIntake", style: TextStyle(color: colors.myOnPrimary, fontSize: 15)),
                            widget.teamsNumberDatas[widget.team]!["intake form ground"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Source\nIntake", style: TextStyle(color: colors.myOnPrimary, fontSize: 15)),
                            widget.teamsNumberDatas[widget.team]!["intake from source"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Speaker", style: TextStyle(color: colors.myOnPrimary, fontSize: 12),),
                            widget.teamsNumberDatas[widget.team]!["speaker?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check),
                            Text(widget.teamsNumberDatas[widget.team]!["how they speaker"]!),
                          ],
                        ),
                      ),
                    ),
                    Container(
                     decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Amp", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["amp?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Climb", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["climb?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Trap", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["trap?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onError,
                        border: Border.all(
                          color: colorScheme.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Stage", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                            widget.teamsNumberDatas[widget.team]!["under Stage?"] == "false" ? Icon(Icons.cancel_outlined) : Icon(Icons.check)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              SizedBox(
                width: width,
                height: height*0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Weight: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["Weight"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Drive: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["drive type"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Intake: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["intake type"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Speed: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["robot speed"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: colorScheme.onError,
                      //     border: Border.all(
                      //       color: colorScheme.onSurface,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   // child: const Padding(
                      //   //   padding: EdgeInsets.all(8.0),
                      //   //   child: Text("drive quality"),
                      //   // ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Bumper quality: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["bumper quality(1-5)"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Motor Num: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["number of motors"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
          
          
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: Text("Performance", style: TextStyle(color: colors.myOnPrimary, fontSize: 35), ),),
              ),




              
              SizedBox(
                width: width,
                height: height*0.35,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Container(
                        width: width*0.3,
                        height: height*0.35,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Score", style: TextStyle(color: colors.myOnPrimary, fontSize: 35),),
                              Text("NA", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("Average",),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["OPR"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("OPR",),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.35,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Notes", style: TextStyle(color: colors.myOnPrimary, fontSize: 35),),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Notes"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("Average",),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Amps per Game"]!).round() + double.parse(widget.teamsNumberDatas[widget.team]!["Speaker per Game"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("OPR",),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.35,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Pass", style: TextStyle(color: colors.myOnPrimary, fontSize: 35),),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Average Passes"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("Average",),
                              Text("NA", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("OPR",),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.35,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Speaker", style: TextStyle(color: colors.myOnPrimary, fontSize: 25),),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Speaker"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("Average",),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Speaker per Game"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("OPR",),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.3,
                        height: height*0.35,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Amp", style: TextStyle(color: colors.myOnPrimary, fontSize: 35),),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Team Avg Amp"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("Average",),
                              Text("${double.parse(widget.teamsNumberDatas[widget.team]!["Amps per Game"]!).round()}", style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                              const Text("OPR",),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8,),

              SizedBox(
                width: width,
                height: height*0.19,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Climb Rate: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["climb rate %"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Trap Rate: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["trap rate %"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text("Breakdown Rate: ", style: TextStyle(color: colors.myOnPrimary, fontSize: 20), ),
                              Text(widget.teamsNumberDatas[widget.team]!["breakdown rate %"]!
                              , style: TextStyle(color: colorScheme.onSurface, fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),




              const Divider(),


              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onError,
                    border: Border.all(
                      color: colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final sheet = await SheetsHelper.sheetSetup("PowerRatings.py");
                      List<String> allTeams = await sheet!.values.column(1);
                      allTeams = allTeams.sublist(1);
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => TeamGraphing(teamName: widget.team, allTeams: allTeams),
                        )
                      );
                    },
                    child: const Text("Graphing", style: TextStyle(color: colors.myOnPrimary, fontSize: 35), ),
                  ),
                ),
              ),




              const Divider(),
              const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: Text("Notes", style: TextStyle(color: colors.myOnPrimary, fontSize: 35), ),),
              ),




              SizedBox(
                width: width,
                height: height*0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Auto Notes", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["Auto Notes"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Acuracy", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["ACC"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Capabilities", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["Capabilities"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Trends", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["Trends"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Field awareness", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["field awareness"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Robot faliures", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["Robot faliures"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Effect avg", style: TextStyle(color: colors.myOnPrimary, fontSize: 20),),
                              Text(widget.teamsNotesDatas[widget.team]!["effect avg"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        height: height*0.5,
                        decoration: BoxDecoration(
                          color: colorScheme.onError,
                          border: Border.all(
                            color: colorScheme.onSurface,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Rel effect avg", style: TextStyle(color: colors.myOnPrimary, fontSize: 15),),
                              Text(widget.teamsNotesDatas[widget.team]!["rel effect avg"]!, style: TextStyle(color: colorScheme.onSurface, fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(),

               Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onError,
                    border: Border.all(
                      color: colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => const RobotPathGraph(),
                        )
                      );
                    },
                    child: const Text("Auto Path", style: TextStyle(color: colors.myOnPrimary, fontSize: 35), ),
                  ),
                ),
              ),

              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
