// server/sql_server_logic.dart
import 'dart:async';
import 'package:frc1148_2023_scouting_app/SQLServerSocket/DartClient/lib/sqlconnection.dart';

Future<List<dynamic>> runSqlQuery(String sql) async {
  final connection = SqlConnection(
    "Server=MT-server\\SQLEXPRESS;"
    "Database=1148-Scouting;"
    "User Id=1148Robotics;Password=1148Robotics;Trusted_Connection=yes;"
  );

  try {
    await connection.open();
    final result = await connection.query(sql);
    await connection.close();
    return result;
  } catch (e) {
    throw e;
  }
}
