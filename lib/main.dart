import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'package:frc1148_2023_scouting_app/entrance.dart';
import 'package:frc1148_2023_scouting_app/SQLServerSocket/DartClient/lib/sqlconnection.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized

  // if (!kIsWeb) {
  //   try {
  //     SqlConnection conn = SqlConnection("Server=localhost\\SQLEXPRESS;Database=1148-Scouting;Trusted_Connection=yes;");
  //     await conn.open();
  //     print("connected");
  //   } catch (e) {
  //     print("Error connecting to the database: $e");
  //   }
  // } else {
  //   print("Database connection is not supported on the web.");
  // }

  try {
    SqlConnection conn = new SqlConnection(
        "Server=MT-server\\SQLEXPRESS;Database=1148-Scouting;User Id=1148Robotics;Password=1148Robotics;Trusted_Connection=yes;");
    await conn.open();
    print("connected");

    // Execute the SELECT * query
    var results = await conn.query("SELECT * FROM PitScouting");

    // Check if any rows were returned
    if (results.isEmpty) {
      print('No data found in the table "PitScouting".');
    } else {
      // Retrieve and print column headers from the first row's keys
      List<String> columnNames = results.first.keys.toList();
      print(columnNames.join(' | '));
      // Print a separator
      print('-' * (columnNames.join(' | ').length));
      // Iterate through each row and print the data
      for (var row in results) {
        List<String> rowData = [];
        for (var key in row.keys) {
          var value = row[key];
          rowData.add(value != null ? value.toString() : 'NULL');
        }
        print(rowData.join(' | '));
      }
    }

    await conn.close();
    print("done");
  } catch (e) {
    print("Error connecting to the database: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Home Page',
      theme: ThemeData.from(colorScheme: lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: darkColorScheme),
      themeMode: themeMode,
      home: Entrance(
        onThemeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    );
  }
}
