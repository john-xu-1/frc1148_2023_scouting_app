import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/log_in.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';
import 'package:frc1148_2023_scouting_app/pit_scouting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      //home: const log_in(title: 'Scouting Home Page'),
        home: pit_scouting(teamName: 'YourTeamNameHere'), // Pass your team name
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.teamName});

  final String teamName;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>[];

  final List<Widget> entryObjects = <ScoutingForm>[];
  
  

  void _incrementCounter() {
    setState(() {
      
      entries.add("entry");
      entryObjects.add( pit_scouting(teamName: widget.teamName));

    });
  }
  int currentPageIndex = 0;

  // void navigateToPage(Widget page) {
  //   setState(() {
  //     pages.add(page);
  //     currentPageIndex = pages.length - 1;
  //   });
  // }

  // void returnToPreviousPage() {
  //   if (currentPageIndex > 0) {
  //     setState(() {
  //       currentPageIndex--;
  //     });
  //   }
  // }

  void createForm (int ind){
    setState(() {
      
      Navigator.push(
        context,
        MaterialPageRoute
        (
          builder: (context) => entryObjects[ind]
        )
      );

    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return Container(
              height: 50,
              color: Colors.amber[300],
              child: Center(
                child: ElevatedButton(
                  child: Text(entries[index]),
                  onPressed: (){
                    createForm(index);
                  }
                )
              )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}