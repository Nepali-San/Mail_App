import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/InboxManager.dart';
import 'package:mail_app_practise/pages/MessageDetails.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mail_app_practise/widgets/Observer.dart';

class MessageList extends StatelessWidget {
  final String status;

  MessageList({this.status = 'important'});

  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    InboxManager contactManager = overseer.fetch(name: InboxManager);

    contactManager.inStatusFilter.add(status);

    return Observer<List<Message>>(
      stream: contactManager.msgStream$,
      onSuccess: (BuildContext context,List<Message> data) {
        List<Message> _messages = data;

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            Message _message = _messages[index];
            return buildSlidable(_message, index, context);
          },
          itemCount: _messages.length,
        );
      },
    );
  }

  Slidable buildSlidable(Message _message, int index, BuildContext context) {
    return Slidable(
      key: Key(_message.subject),
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
              builder: (context) =>
                  MessageDetail(title: _message.subject, body: _message.body),
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
          onTap: () {},
        ),
      ],
    );
  }
}
