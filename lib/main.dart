import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/scout_window.dart';
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
      initialRoute: '/home', // Set the initial route to '/home'
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Scouting Home Page'),
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

  final List<Widget> entryObjects = <ScoutingForm>[];
  
  

  void _incrementCounter() {
    setState(() {
      
      entries.add("entry");

      entryObjects.add( const ScoutingForm(title: "test"));


      _counter++;
    });
  }

   List<Widget> pages = [ScoutingForm(title: "test",)];
  int currentPageIndex = 0;

  void navigateToPage(Widget page) {
    setState(() {
      pages.add(page);
      currentPageIndex = pages.length - 1;
    });
  }

  void returnToPreviousPage() {
    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
      });
    }
  }

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
        title: Text("Home"),
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
