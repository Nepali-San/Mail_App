import 'package:flutter/material.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/widgets/ComposeBtn.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> messages;

  @override
  void initState() {
    messages = Message.browse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                messages = Message.browse();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: messages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('There is an error : ${snapshot.error}'),
                );
              }
              List<Message> _messages = snapshot.data;
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  Message message = _messages[index];
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
                    onTap: (){}
                  );
                },
                itemCount: _messages.length,
              );
            default:
              return Center(
                child: Text('Something went wrong !!!'),
              );
          }
        },
      ),
      floatingActionButton: ComposeBtn(),
    );
  }
}
