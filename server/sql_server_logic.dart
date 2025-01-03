// server/sql_server_logic.dart
import 'dart:async';
import 'package:frc1148_2023_scouting_app/SQLServerSocket/DartClient/lib/sqlconnection.dart'; // We'll adapt your "raw" code to actually talk to MSSQL?
// or any other direct MSSQL driver if you have one.

SqlConnection? _globalConn;

/// "Open" the SQL connection with the given connection string
Future<void> openSqlConnection(String connectionString) async {
  if (_globalConn != null && _globalConn!.connected) {
    // Already open
    return;
  }
  // Construct your old SqlConnection which uses raw TCP to (maybe) talk to a .NET server?
  // or if you adapted it to talk directly to MSSQL, do that here.
  _globalConn = SqlConnection(
    connectionString,
    address: "MT-server",  // or "localhost"
    port: 10980           // This is suspicious if you want direct DB or your .NET bridge?
  );

  print('[sql_server_logic] about to .open()');
  await _globalConn!.open();
  print('[sql_server_logic] open() complete, connected? ${_globalConn!.connected}');
}

/// run a query
Future<Map<String, dynamic>> runSqlQuery(String sql) async {
  if (_globalConn == null || !_globalConn!.connected) {
    throw 'No open SQL connection.';
  }

  print('[sql_server_logic] about to .query("$sql")');
  final rows = await _globalConn!.query(sql);
  print('[sql_server_logic] got ${rows.length} rows.');

  // If your old code returns List<dynamic>, we just return that plus maybe a "columns" stub
  return {
    "rows": rows,
    "columns": {}, // if your code doesn't return column info, just return an empty object
  };
}

/// close the connection
Future<void> closeSqlConnection() async {
  if (_globalConn == null || !_globalConn!.connected) {
    return;
  }
  await _globalConn!.close();
  print('[sql_server_logic] connection closed.');
  _globalConn = null;
}
