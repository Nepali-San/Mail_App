import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List messages = [];

  Future loadMessageList() async {
    var content = await rootBundle.loadString('data/message.json');
    var collection = json.decode(content);
    setState(() {
      messages = collection;
    });
  }

  @override
  void initState() {
    loadMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email App'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          final Map message = messages[index];

          return ListTile(
            title: Text(message['subject']),
            subtitle: Text(
              message['body'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              child: Text("A"),
            ),
            isThreeLine: true,
          );
        },
        itemCount: messages.length,
      ),
    );
  }
}
