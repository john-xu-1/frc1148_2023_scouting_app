// Copyright (c) 2015, Antonino Porcino. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../lib/sqlconnection.dart';
import '../lib/table.dart';

main() async {
  //var connstr = @"Server=DEVIL\\SQLEXPRESS;Database=Phoenix64;User Id=sa;Password=;";
  SqlConnection conn = new SqlConnection(
      "Server=192.168.68.135\\SQLEXPRESS;Database=1148-Scouting;User Id=1148Robotics;Password=1148Robotics;Trusted_Connection=yes;");

  await conn.open();

  print("connected");

  /*
   List rows = await conn.query("SELECT TOP 3 Id,Nome,Cognome FROM Comuni_Anagrafe");
      
   print("queried");
   
   for(var r in rows)
   {
      print(r["Cognome"]);
   }
   */

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

  // for (var r in tab.rows) {
  //   print(r["Cognome"]);
  // }

  // var r = tab.newRow();
  // r["Cognome"] = "pisapia";
  // r["Nome"] = "alessio";
  // tab.rows.add(r);

  // await tab.post();

  /*
   var s = await conn.queryValue("SELECT DataStampa FROM Mag_DocMag WHERE DataStampa IS NOT NULL");
   
   assert(s is DateTime);
   
   print("dbname=$s");
   
   await conn.close();
   */
  await conn.close();
  print("done");
}
