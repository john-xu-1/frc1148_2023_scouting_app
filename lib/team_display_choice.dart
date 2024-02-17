import 'package:flutter/material.dart';
import 'team_display_instance.dart';
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'sheets_helper.dart';

class TeamDisplayChoice extends StatefulWidget {
  const TeamDisplayChoice({super.key});

  @override
  State<TeamDisplayChoice> createState() => _TeamDisplayChoiceState();
}

class _TeamDisplayChoiceState extends State<TeamDisplayChoice> {
  List<String> allTeams = List.empty();
  List<TeamDisplayInstance> allTeamDisplays = [];

  Future<void> _updateTeams() async {
    try {
      final sheet = await SheetsHelper.sheetSetup("PowerRatings.py");

      allTeams = await sheet!.values.column(1);
      allTeams = allTeams.sublist(1);
      setState(() {
        for (int i = 0; i < allTeams.length; i++) {
          allTeamDisplays.add(TeamDisplayInstance(teamID: allTeams[i]));
        }
      }); //referesh after successful fetch
      print(allTeams.length);
      print(allTeamDisplays.length);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    _updateTeams();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (allTeams.isEmpty) {
      return const SafeArea(
        child: Scaffold(
            backgroundColor: colors.myBackground,
            body: Center(
              child: Text(
                "loading ...",
                style: TextStyle(color: colors.myOnPrimary),
              ),
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: allTeams.length,
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
                          child: Text(allTeams[index]),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => allTeamDisplays[index])
                            );
                          }
                      )
                    )
                ],
              ),
            );
          },
          //separatorBuilder: (BuildContext context, int index) => const Divider(),
          separatorBuilder: (BuildContext context, int index) => Container(
            alignment: AlignmentDirectional.center,
            height: height / 150,
            //child: const Divider(),
          ),
          //
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
