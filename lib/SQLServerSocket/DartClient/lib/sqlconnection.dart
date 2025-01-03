library sql_server_socket;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

// Make sure this import points to wherever your `table.dart` really is.
// Example path:
import 'table.dart';

/// A raw‐socket SQL client that sends/receives length‐prefixed JSON
/// commands like {"type":"open","text":"Server=..."} to a bridging server.
///
/// This matches your .NET server’s custom protocol on port 10981.
class SqlConnection {
  late Socket _socket;
  late StringBuffer _receiveBuffer;
  late Completer<String> _completer;
  late bool _connected;

  late String _address;           // e.g. "MT-server" or "localhost"
  late int _port;                 // e.g. 10981
  late String _connectionString;  // e.g. "Server=MT-server\\SQLEXPRESS;Database=..."

  /// By default, use address="MT-server" and port=10981.
  /// Adjust these defaults or override them in the constructor for your scenario.
  SqlConnection(
    String connStr, {
    String address = "MT-server",
    int port = 10981,
  }) {
    _address = address;
    _port = port;
    _connected = false;
    _connectionString = connStr;
  }

  bool get connected => _connected;

  /// Opens a raw TCP Socket to [_address]:[_port],
  /// then sends {"type":"open","text":_connectionString}.
  ///
  /// If the server responds with {"type":"ok"}, sets [_connected]=true.
  /// If it responds with {"type":"error"}, throws an error.
  Future<bool> open() async {
    try {
      print('[SqlConnection/Raw] connecting to $_address:$_port ...');
      _socket = await Socket.connect(_address, _port);
      print('[SqlConnection/Raw] connected!');
    } catch (ex) {
      throw "can't connect to $_address:$_port -- $ex";
    }

    // Listen for server data
    utf8.decoder.bind(_socket).listen(
      _receiveData,
      onError: _onError,
      onDone: _onDone,
    );

    final connectCompleter = Completer<bool>();

    // Send the "open" command: {"type":"open","text":_connectionString}
    final jsonCmd = jsonEncode({
      "type": "open",
      "text": _connectionString,
    });

    _sendCommand(jsonCmd).then((responseStr) {
      final res = _parseResult(responseStr);
      if (res is _OkResult) {
        _connected = true;
        connectCompleter.complete(true);
      } else if (res is _ErrorResult) {
        _connected = false;
        connectCompleter.completeError(res.error);
      } else {
        throw "unknown response to open()";
      }
    }).catchError((err) {
      _connected = false;
      connectCompleter.completeError(err);
    });

    return connectCompleter.future;
  }

  /// Closes the connection by sending {"type":"close","text":""}.
  /// If successful, sets [_connected]=false.
  Future<bool> close() {
    if (!connected) {
      throw "not connected";
    }
    final disconnectCompleter = Completer<bool>();

    final jsonCmd = jsonEncode({
      "type": "close",
      "text": "",
    });

    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);
      if (res is _OkResult) {
        _connected = false;
        disconnectCompleter.complete(true);
      } else if (res is _ErrorResult) {
        disconnectCompleter.completeError(res.error);
      } else {
        throw "unknown response to close()";
      }
    }).catchError((err) {
      disconnectCompleter.completeError(err);
    });

    return disconnectCompleter.future;
  }

  /// Launches a query returning a `Table` object, i.e. {"type":"table","text":"..."}.
  /// If the server responds with {"type":"table", ...} we build and return a Table instance.
  Future<Table> queryTable(String sql) {
    if (!connected) {
      throw "not connected";
    }

    final jsonCmd = jsonEncode({
      "type": "table",
      "text": sql,
    });

    final compl = Completer<Table>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);

      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _TableResult) {
        final table = Table(
          this,
          res.tableName,
          res.rows,
          res.columns,
        );
        compl.complete(table);
      } else {
        throw "unknown response to queryTable()";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Launches a "postback" operation, i.e. {"type":"postback","text":"..."}.
  /// Typically used to send updated rows to the server.
  Future<PostBackResponse> postBack(ChangeSet chg) {
    if (!connected) {
      throw "not connected";
    }

    final params = jsonEncode(chg.toEncodable());
    final jsonCmd = jsonEncode({
      "type": "postback",
      "text": params,
    });

    final compl = Completer<PostBackResponse>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);

      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _PostBackResult) {
        final resp = PostBackResponse();
        resp.idcolumn = res.idcolumn;
        resp.identities = res.identities;
        compl.complete(resp);
      } else {
        throw "invalid postback response";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Launches a basic query returning all rows (List<dynamic>),
  /// i.e. {"type":"query","text":"..."} => {"type":"query","rows":[...]}
  Future<List<dynamic>> query(String sql) {
    if (!connected) {
      throw "not connected";
    }

    final jsonCmd = jsonEncode({
      "type": "query",
      "text": sql,
    });

    final compl = Completer<List<dynamic>>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);
      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _QueryResult) {
        compl.complete(res.rows);
      } else {
        throw "unknown response to query()";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Query returning first row only (Map<String,dynamic>?)
  Future<Map<String, dynamic>?> querySingle(String sql) {
    if (!connected) {
      throw "not connected";
    }

    final jsonCmd = jsonEncode({
      "type": "querysingle",
      "text": sql,
    });

    final compl = Completer<Map<String,dynamic>?>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);
      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _QueryResult) {
        if (res.rows.isEmpty) {
          compl.complete(null);
        } else {
          compl.complete(res.rows[0]);
        }
      } else {
        throw "unknown response to querySingle()";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Query returning the first column of the first row
  Future<dynamic> queryValue(String sql) {
    if (!connected) {
      throw "not connected";
    }

    final jsonCmd = jsonEncode({
      "type": "queryvalue",
      "text": sql,
    });

    final compl = Completer<dynamic>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);
      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _QueryResult) {
        if (res.rows.isEmpty) {
          compl.complete(null);
        } else {
          // The server typically returns rows[0]["value"]
          compl.complete(res.rows[0]["value"]);
        }
      } else {
        throw "unknown response to queryValue()";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Executes a SQL command (INSERT, UPDATE, DELETE) returning # of rows affected
  Future<int> execute(String sql) {
    if (!connected) {
      throw "not connected";
    }

    final jsonCmd = jsonEncode({
      "type": "execute",
      "text": sql,
    });

    final compl = Completer<int>();
    _sendCommand(jsonCmd).then((respStr) {
      final res = _parseResult(respStr);
      if (res is _ErrorResult) {
        compl.completeError(res.error);
      } else if (res is _QueryResult) {
        if (res.rows.isEmpty) {
          compl.complete(-1);
        } else {
          compl.complete(res.rows[0]["rowsAffected"]);
        }
      } else {
        throw "unknown response to execute()";
      }
    }).catchError((err) {
      compl.completeError(err);
    });

    return compl.future;
  }

  /// Internal: sends the "length\r\njson" command to the raw socket,
  /// and returns a Future that completes when we get a matching response.
  Future<String> _sendCommand(String command) {
    _receiveBuffer = StringBuffer();
    _completer = Completer<String>();

    final cmd = '${command.length}\r\n$command';
    _socket.write(cmd);

    return _completer.future;
  }

  void _onDone() {
    // Called when the server closes the socket
    print('[SqlConnection/Raw] onDone() - socket closed?');
  }

  void _onError(error) {
    print('[SqlConnection/Raw] onError: $error');
  }

  /// Accumulate incoming data, look for "len\r\npayload".
  /// Once we have a complete chunk, complete the _completer with the JSON string.
  void _receiveData(dynamic data) {
    _receiveBuffer.write(data);

    final content = _receiveBuffer.toString();
    final idx = content.indexOf("\r\n");
    if (idx > 0) {
      final len = int.parse(content.substring(0, idx));
      final cmd = content.substring(idx + 2);
      if (cmd.length == len) {
        // We have a complete JSON payload
        _completer.complete(cmd);
      }
    }
  }

  /// Parse the JSON result from the bridging server into one of the internal result classes
  dynamic _parseResult(String jsonStr) {
    final Map result = jsonDecode(jsonStr);

    if (result["type"] == "ok") {
      return _OkResult("ok");
    } else if (result["type"] == "error") {
      return _ErrorResult(result["error"]);
    } else if (result["type"] == "query") {
      return _QueryResult(result["rows"], result["columns"]);
    } else if (result["type"] == "table") {
      return _TableResult(
        result["tablename"],
        result["rows"],
        result["columns"],
      );
    } else if (result["type"] == "postback") {
      return _PostBackResult(result["idcolumn"], result["identities"]);
    } else {
      throw "unknown response: ${result["type"]}";
    }
  }
}

// ---------- internal result classes ---------- //

class _ErrorResult {
  late String error;
  _ErrorResult(this.error);
}

class _OkResult {
  late String ok;
  _OkResult(this.ok);
}

/// For { "type":"query","rows": [ ... ], "columns": { ... } }
class _QueryResult {
  late List<dynamic> rows;
  late Map<String, dynamic> columns;

  _QueryResult(List<dynamic> rows, Map<String, dynamic>? columns) {
    this.rows = rows;
    this.columns = columns ?? {};
    // Optionally fix column types if you store them in 'columns'
    for (var colName in this.columns.keys) {
      TypeFixer.fixColumn(rows, colName, this.columns[colName]);
    }
  }
}

/// For { "type":"table","tablename":"...","rows":[...],"columns":[...] }
class _TableResult {
  late String tableName;
  late List<Map<String, dynamic>> rows;
  late List<Map<String, String>> columns;

  _TableResult(
    String tableName,
    List<Map<String, dynamic>> rows,
    List<Map<String, String>> columns,
  ) {
    this.tableName = tableName;
    this.rows = rows;
    this.columns = columns;
  }
}

/// For { "type":"postback","idcolumn":"...","identities":[1,2,3] }
class _PostBackResult {
  late String idcolumn;
  late List<int> identities;

  _PostBackResult(String idcolumn, List<int> identities) {
    this.idcolumn = idcolumn;
    this.identities = identities;
  }
}

/// Optionally used to fix "datetime" or other typed columns
class TypeFixer {
  static void fixColumn(
    List<dynamic> rows,
    String columnName,
    String columnType,
  ) {
    if (columnType == "datetime") {
      for (int i = 0; i < rows.length; i++) {
        if (rows[i][columnName] != null) {
          rows[i][columnName] = DateTime.parse(rows[i][columnName]);
        }
      }
    }
  }
}
