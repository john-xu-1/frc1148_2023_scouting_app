// server/server.dart
import 'dart:io';
import 'dart:convert';

// (Optional) Import your custom SQL logic:
import 'sql_server_logic.dart';
// or import 'sqlconnection.dart' if you keep it in the server folder

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 10980);
  print('Server running on ws://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final socket = await WebSocketTransformer.upgrade(request);
      print('New WebSocket connection: ${socket.hashCode}');
      
      socket.listen(
        (message) async {
          // parse JSON from the client
          try {
            final data = jsonDecode(message);
            // e.g. data might be { "type": "query", "sql": "SELECT * FROM PitScouting" }
            if (data['type'] == 'query') {
              // do your SQL query:
              final sql = data['sql'];
              final results = await runSqlQuery(sql); 
              // runSqlQuery is your custom function that internally uses SqlConnection
              
              // send results back
              socket.add(jsonEncode({
                'type': 'queryResult',
                'rows': results,
              }));
            } else {
              socket.add(jsonEncode({'error': 'Unknown message type'}));
            }
          } catch (e) {
            socket.add(jsonEncode({'error': e.toString()}));
          }
        },
        onError: (err) {
          print('WebSocket error: $err');
        },
        onDone: () {
          print('WebSocket closed: ${socket.hashCode}');
        },
      );
    } else {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
    }
  }
}
