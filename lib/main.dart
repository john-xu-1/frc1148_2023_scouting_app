// lib/main.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/html.dart'; 
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebSocketChannel channel;
  String _messages = "";

  @override
  void initState() {
    super.initState();
    // Connect to your server’s WebSocket
    channel = HtmlWebSocketChannel.connect('ws://<YOUR_SERVER_IP>:10980');
    channel.stream.listen(
      (message) {
        setState(() {
          _messages += "Server: $message\n";
        });
      },
      onError: (err) => print('WebSocket error: $err'),
      onDone: () => print('WebSocket closed'),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _sendQuery() {
    // For example, send a query for PitScouting
    final queryRequest = {
      'type': 'query',
      'sql': 'SELECT * FROM PitScouting',
    };
    channel.sink.add(jsonEncode(queryRequest));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SQL WebSocket Demo')),
        body: Center(
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(child: Text(_messages))),
              ElevatedButton(
                onPressed: _sendQuery,
                child: Text('Send Query to Server'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
