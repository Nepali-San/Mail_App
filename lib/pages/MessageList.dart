import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/MessageDetails.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/widgets/ComposeBtn.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    var drawerItems = Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('123here.comes.san@gmail.com'),
            accountName: Text('San Neupane'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://i.pinimg.com/originals/a5/76/46/a576463a3b5a9e8cb2a22b47c45a6a7f.jpg",
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.inbox),
            title: Text(
              'Inbox',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Chip(
              label: Text('11', style: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.blue[100],
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.userEdit),
            title: Text(
              'Draft',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.archive),
            title: Text(
              'Archive',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.paperPlane),
            title: Text(
              'Sent',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trash),
            title: Text(
              'Trash',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );

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
      drawer: drawerItems,
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
