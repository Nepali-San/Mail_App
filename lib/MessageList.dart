import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mail_app_practise/model/message.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<Message> messages = [];

  Future loadMessageList() async {
    //load the json file.
    String content = await rootBundle.loadString('data/message.json');

    //decode the json, since first symbol is square bracket , our json is the "list of dynamic" so it return list<dynamic>
    //if first symbol was { then it would return Map<String,dynamic>.

    List<dynamic> collection = json.decode(content);

    setState(() {
      //use contructor to typecast the json into object.
      messages = collection.map((json) => Message.fromJson(json)).toList();

      // above contructor does the same task as below constructor.
      //   messages = collection
      //       .map((json) => Message(
      //             subject: json['subject'],
      //             body: json['body'],
      //           ))
      //       .toList();
      // });
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
          Message message = messages[index];

          return ListTile(
            title: Text(message.subject),
            subtitle: Text(
              message.body,
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
