import 'package:flutter/material.dart';
import 'package:frc1148_2023_scouting_app/lead_scouting.dart';
import 'draw_area.dart';
import 'sheets_helper.dart';
import 'color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final List<String> entries = <String>[
    'Enter assigned Letter',
    'Enter match # (ex: 5)',
  ];

  // TextEditingControllers for the TextFields
  final TextEditingController idController = TextEditingController();
  final TextEditingController mnumController = TextEditingController();

  // Variables to hold the fetched data
  Map<String, List<String>> scoutLists = <String, List<String>>{};

  // Future to handle data fetching
  late Future<void> _fetchDataFuture;

  String A = "";
  String B = "";
  String C = "";
  String D = "";
  String E = "";
  String F = "";

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchAndFormatData();
  }

  Future<void> fetchAndFormatData() async {
    try {
      await fetchTeamFromSheets();
      formatSheetsTeamsData();
      print('Data fetched and formatted successfully.');
    } catch (e) {
      print('Error during data fetching and formatting: $e');
      // Optionally, you can rethrow the error to handle it in FutureBuilder
      // throw e;
    }
  }

  Future<void> fetchTeamFromSheets() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Check if data is already cached
      if (prefs.containsKey('A')) {
        // Load data from cache
        A = prefs.getString('A') ?? '';
        B = prefs.getString('B') ?? '';
        C = prefs.getString('C') ?? '';
        D = prefs.getString('D') ?? '';
        E = prefs.getString('E') ?? '';
        F = prefs.getString('F') ?? '';

        print('Loaded data from cache');
      } else {
        // Fetch data from Google Sheets
        final sheet = await SheetsHelper.sheetSetup('Scouting Assignment');

        if (sheet == null) {
          throw Exception('Sheet is null');
        }

        // Fetch the range of cells in a single call
        final cells = await sheet.values.allRows(
          fromRow: 1,
          fromColumn: 2,
          length: 7,
        );

        if (cells.isEmpty) {
          throw Exception('No data found in the specified range');
        }

        // Assign the values to the variables
        A = cells[0][0];
        B = cells[1][0];
        C = cells[2][0];
        D = cells[4][0]; // Adjust index if necessary
        E = cells[5][0];
        F = cells[6][0];

        // Save data to cache
        await prefs.setString('A', A);
        await prefs.setString('B', B);
        await prefs.setString('C', C);
        await prefs.setString('D', D);
        await prefs.setString('E', E);
        await prefs.setString('F', F);

        print('Fetched data from Google Sheets and saved to cache');
      }

      print('Data:');
      print('A: $A');
      print('B: $B');
      print('C: $C');
      print('D: $D');
      print('E: $E');
      print('F: $F');
    } catch (e) {
      print('Error fetching data: $e');
      // Optionally rethrow the error
      // throw e;
    }
  }

  void formatSheetsTeamsData() {
    scoutLists["a"] = A.split(',').map((item) => item.trim()).toList();
    scoutLists["b"] = B.split(',').map((item) => item.trim()).toList();
    scoutLists["c"] = C.split(',').map((item) => item.trim()).toList();
    scoutLists["d"] = D.split(',').map((item) => item.trim()).toList();
    scoutLists["e"] = E.split(',').map((item) => item.trim()).toList();
    scoutLists["f"] = F.split(',').map((item) => item.trim()).toList();

    print('Formatted scoutLists: $scoutLists');
  }

  String updateResults(String id, String mnum) {
    // After the match number and identifier are input, changes the identifier's value
    int index = int.tryParse(mnum) ?? -1;
    String result = "";

    if (index < 1 || id.isEmpty) {
      print("Invalid input: id='$id', mnum='$mnum'");
      return result; // Invalid index
    }

    id = id.toLowerCase();

    if (id == 'x') {
      if (index <= scoutLists["a"]!.length &&
          index <= scoutLists["b"]!.length &&
          index <= scoutLists["c"]!.length) {
        result =
            "${scoutLists["a"]![index - 1]}, ${scoutLists["b"]![index - 1]}, ${scoutLists["c"]![index - 1]}";
      } else {
        print("Index out of bounds for 'x'");
      }
    } else if (id == 'y') {
      if (index <= scoutLists["d"]!.length &&
          index <= scoutLists["e"]!.length &&
          index <= scoutLists["f"]!.length) {
        result =
            "${scoutLists["d"]![index - 1]}, ${scoutLists["e"]![index - 1]}, ${scoutLists["f"]![index - 1]}";
      } else {
        print("Index out of bounds for 'y'");
      }
    } else if (scoutLists.containsKey(id)) {
      if (index <= scoutLists[id]!.length) {
        result = scoutLists[id]![index - 1];
      } else {
        print("Index out of bounds for id '$id'");
      }
    } else {
      print("Invalid ID '$id'");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Scouting Log In"),
      ),
      body: FutureBuilder<void>(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is loading, show a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there was an error loading the data, display an error message
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          } else {
            // Data loaded successfully, build the main UI
            return buildMainContent(context);
          }
        },
      ),
    );
  }

  Widget buildMainContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 3.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      entries[0],
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      width: width / 3,
                      child: TextField(
                        controller: idController,
                        cursorColor: colors.myOnSurface,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter ID',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 3.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      entries[1],
                      textScaleFactor: 1.5,
                    ),
                    SizedBox(
                      width: width / 3,
                      child: TextField(
                        controller: mnumController,
                        cursorColor: colors.myOnSurface,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Match Number',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String id = idController.text.trim();
                String mnum = mnumController.text.trim();

                String results = updateResults(id, mnum);

                print('Results: $results');

                if (results.isNotEmpty) {
                  final String out = "q$mnum $results";
                  try {
                    if (id.toLowerCase() == 'x' || id.toLowerCase() == 'y') {
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => LeadScouting(teamName: out)
                        )
                      );
                    }
                    else{
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context) => DrawArea(teamName: out, id: id,)
                        )
                      );
                    }
                  } catch (e) {
                    print('Error during navigation: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Error navigating to the next screen: $e'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  // Show an error message if results are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid ID or Match Number'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Icon(Icons.send, color: colors.myOnPrimary,),
            )
          ],
        ),
      ),
    );
  }
}
