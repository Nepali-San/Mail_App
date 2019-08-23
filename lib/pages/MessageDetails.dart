import 'package:flutter/material.dart';

class MessageDetail extends StatelessWidget {
  final String title, body;

  MessageDetail({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('$body'),
      ),
    );
  }
}
