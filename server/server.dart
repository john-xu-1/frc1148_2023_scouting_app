import 'dart:io';
import 'dart:convert';
import 'package:frc1148_2023_scouting_app/SQLServerSocket/DartClient/lib/sqlconnection.dart';
import 'package:frc1148_2023_scouting_app/SQLServerSocket/DartClient/lib/table.dart';

SqlConnection? globalConn;

Future<void> main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 10980);
  print('WebSocket bridging server running on ws://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final ws = await WebSocketTransformer.upgrade(request);
      print('New WebSocket connection: ${ws.hashCode}');

      final buffer = StringBuffer();

      ws.listen(
        (data) async {
          // data is "length\r\njson"
          buffer.write(data);
          final content = buffer.toString();
          final idx = content.indexOf('\r\n');
          if (idx > 0) {
            final len = int.parse(content.substring(0, idx));
            final cmd = content.substring(idx + 2);
            if (cmd.length == len) {
              buffer.clear();
              try {
                final message = jsonDecode(cmd);
                if (message is Map) {
                  await _handleMessage(ws, message.cast<String, dynamic>());
                }
              } catch (e, st) {
                print('Error parsing JSON: $e\n$st');
                _sendReply(ws, {"type": "error", "error": "Invalid JSON: $e"});
              }
            }
          }
        },
        onError: (err) => print('WebSocket error: $err'),
        onDone: () => print('WebSocket closed: ${ws.hashCode}'),
      );
    } else {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
    }
  }
}

Future<void> _handleMessage(WebSocket ws, Map<String, dynamic> msg) async {
  final type = msg["type"];
  final text = msg["text"] ?? "";

  switch (type) {
    case "open":
      {
        print('Client requests "open" with connStr="$text"');
        globalConn?.close();

        globalConn = SqlConnection(
          text,
          address: "MT-server", // your .NET bridging server machine name / IP
          port: 10981,         // .NET bridging server's port
        );
        try {
          await globalConn!.open();
          print('globalConn connected: ${globalConn!.connected}');
          _sendReply(ws, {"type": "ok"});
        } catch (e) {
          print('Error opening connection: $e');
          _sendReply(ws, {"type": "error", "error": e.toString()});
        }
      }
      break;

    case "query":
      {
        if (globalConn == null || !globalConn!.connected) {
          _sendReply(ws, {"type": "error", "error": "No open connection."});
          return;
        }
        print('Client requests "query" => $text');

        final stopwatch = Stopwatch()..start(); // Start timing

        try {
          // Actually call the raw-socket .NET bridging
          final rows = await globalConn!.query(text);

          stopwatch.stop(); // End timing

          // Print the rows in a nice table format
          if (rows.isEmpty) {
            print('[Query] No rows returned.');
          } else {
            // Attempt to guess columns from the first row if it's a Map
            // (You can also check _QueryResult.columns if the server returns them)
            if (rows.first is Map<String, dynamic>) {
              final firstRow = rows.first as Map<String, dynamic>;
              final columns = firstRow.keys.toList();
              // Print column headers
              print(columns.join(' | '));
              // Print a separator line
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
            } else {
              // If it's not a list of maps, just print raw
              print('[Query] Got ${rows.length} rows (not Map-based).');
              print(rows);
            }
          }

          print('Query completed in ${stopwatch.elapsedMilliseconds} ms.');

          // Also respond back to Flutter with the rows
          _sendReply(ws, {"type": "query", "rows": rows});
        } catch (e, st) {
          stopwatch.stop();
          print('Error in query: $e\n$st');
          _sendReply(ws, {"type": "error", "error": e.toString()});
        }
      }
      break;

    case "close":
      {
        print('Client requests "close"');
        if (globalConn != null && globalConn!.connected) {
          await globalConn!.close();
          globalConn = null;
        }
        _sendReply(ws, {"type": "ok"});
      }
      break;

    default:
      _sendReply(ws, {"type": "error", "error": "Unknown message type: $type"});
      break;
  }
}

/// Helper to send length‐prefixed JSON back to Flutter
void _sendReply(WebSocket ws, Map<String, dynamic> msg) {
  final encoded = jsonEncode(msg);
  final prefix = '${encoded.length}\r\n';
  ws.add(prefix + encoded);
}
