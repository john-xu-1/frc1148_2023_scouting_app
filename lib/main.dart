import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/Log_In.dart';
import 'package:frc1148_2023_scouting_app/scouting_form.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const log_in(title: 'Scouting Home Page'),
      home: pit_scouting(teamName: 'YourTeamNameHere'), // Pass your team name

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<String> entries = <String>[];
  
  

  void _incrementCounter() {
    setState(() {
      
      entries.add("entry");


      _counter++;
    });
  }

  void createForm (){
    setState(() {
      
      Navigator.push(
        context,
        MaterialPageRoute
        (
          
          builder: (context) => ScoutingForm(title: "test")
        )
      );

    });
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return Container(
              height: 50,
              color: Colors.deepPurple.shade50,
              child: Center(
                child: ElevatedButton(
                  child: Text(entries[index]),
                  onPressed: createForm,
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
