import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/MessageDetails.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessageList extends StatefulWidget {
  final String status;

  MessageList({this.status = 'important'});

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
    future = Message.browse(status: widget.status);
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            // List<Message> _messages = snapshot.data;
            List<Message> _messages = messages;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                Message _message = messages[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
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
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Archive',
                      color: Colors.blue,
                      icon: Icons.archive,
                      onTap: () => print('Archive'),
                    ),
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () => print('Share'),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () => print('More'),
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        setState(() {
                          messages.removeAt(index);
                        });
                      },
                    ),
                  ],
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
    );
    // since the data used by composeBtn depends on async , we need to wrap it with
    // future builder
    // Else we will be rendering this widget before with get messages list and we will pass empty list
    // floatingActionButton:
    // FutureBuilder(
    //   future: future,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done &&
    //         snapshot.hasData) {
    //       return ComposeBtn(messages: messages);
    //     }
    //     return Container();
    //   },
    // );
  }
}
