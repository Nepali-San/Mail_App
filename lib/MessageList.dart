import 'package:flutter/material.dart';
import 'package:mail_app_practise/MessageDetails.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/widgets/ComposeBtn.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    future = Message.browse();
    messages = await future;
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
                fetch();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: future,
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
                  Message _message = _messages[index];
                  return ListTile(
                    title: Text(_message.subject),
                    subtitle: Text(
                      _message.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageDetail(
                              title: _message.subject, body: _message.body),
                        ),
                      );
                    },
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
      // since the data used by composeBtn depends on async , we need to wrap it with
      // future builder
      // Else we will be rendering this widget before with get messages list and we will pass empty list
      floatingActionButton: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ComposeBtn(messages: messages);
          }
          return Container();
        },
      ),
    );
  }
}
