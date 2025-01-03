import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Keep your existing imports
import 'package:frc1148_2023_scouting_app/color_scheme.dart';
import 'package:frc1148_2023_scouting_app/entrance.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  WebSocketChannel? _channel;
  Stopwatch? _queryStopwatch; // We'll store a stopwatch for timing client-side round-trip

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  /// 1) Connect to your bridging server on port 10980 (WebSocket).
  /// 2) Send only "open". Wait for "ok". Then we'll send "query".
  void _connectWebSocket() {
    final url = 'ws://192.168.68.112:10980'; // Adjust IP if needed
    print('Connecting to bridging server at $url');

    _channel = HtmlWebSocketChannel.connect(url);
    _channel!.stream.listen(
      (rawMessage) {
        print('Received from server (raw): $rawMessage');
        _handleServerMessage(rawMessage);
      },
      onError: (err) => print('WebSocket onError: $err'),
      onDone: () => print('WebSocket connection closed.'),
    );

    // Step A: Send "open" first, do not query until we get "ok".
    final openCmd = {
      "type": "open",
      "text": "Server=MT-server\\SQLEXPRESS;"
          "Database=1148-Scouting;"
          "User Id=MYUSER;Password=MYPASS;"
          "Trusted_Connection=yes;",
    };
    _sendLengthPrefixed(openCmd);
  }

  /// Parse "length\r\njson" from the server
  void _handleServerMessage(String raw) {
    try {
      final i = raw.indexOf('\r\n');
      if (i > 0) {
        final len = int.parse(raw.substring(0, i));
        final jsonPart = raw.substring(i + 2);
        if (jsonPart.length == len) {
          final decoded = jsonDecode(jsonPart);
          _processDecoded(decoded);
        } else {
          print('Length mismatch: got ${jsonPart.length}, expected $len');
        }
      } else {
        print('No \\r\\n found in message: $raw');
      }
    } catch (e) {
      print('Error parsing server message: $e');
    }
  }

  /// Handle JSON from the bridging server
  void _processDecoded(dynamic msg) {
    if (msg is! Map) {
      print('Server message is not a Map: $msg');
      return;
    }
    final type = msg["type"];
    switch (type) {
      case "ok":
        print('Server says open is OK. Now we can safely send a query...');
        _sendQuery();
        break;

      case "error":
        print('Server error: ${msg["error"]}');
        break;

      case "query":
        _queryStopwatch?.stop();
        final elapsedMs = _queryStopwatch?.elapsedMilliseconds ?? 0;

        final rows = msg["rows"];
        print('Received "query" response. Printing in table format...');
        if (rows is List && rows.isNotEmpty && rows.first is Map<String, dynamic>) {
          final firstRow = rows.first as Map<String, dynamic>;
          final columns = firstRow.keys.toList();

          // Print column headers
          print(columns.join(' | '));
          // Print a separator
          print('-' * (columns.join(' | ').length));

          // Print each row
          for (final row in rows) {
            final rowMap = row as Map<String, dynamic>;
            final rowData = columns.map((col) {
              final val = rowMap[col];
              return val == null ? 'NULL' : val.toString();
            }).toList();
            print(rowData.join(' | '));
          }
          print('Query completed in ${elapsedMs} ms (client-side timing).');
        } else if (rows is List && rows.isEmpty) {
          print('Query returned 0 rows. Completed in ${elapsedMs} ms.');
        } else {
          // If it's not a list of maps, just print raw
          print('Query returned data in an unexpected format: $rows');
          print('Completed in ${elapsedMs} ms.');
        }
        break;

      default:
        print('Unknown message type: $type => $msg');
        break;
    }
  }

  /// Send "query" after we get "ok" from "open"
  void _sendQuery() {
    // Start a stopwatch so we can measure how long it takes from here
    _queryStopwatch = Stopwatch()..start();

    final queryCmd = {
      "type": "query",
      "text": "SELECT * FROM PitScouting",
    };
    _sendLengthPrefixed(queryCmd);
  }

  /// Helper: length‐prefix the JSON and send
  void _sendLengthPrefixed(Map<String, dynamic> msg) {
    final encoded = jsonEncode(msg);
    final prefix = '${encoded.length}\r\n';
    final finalStr = prefix + encoded;
    print('Sending to server: $finalStr');
    _channel!.sink.add(finalStr);
  }

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
