import 'package:flutter/material.dart';
import 'package:mail_app_practise/model/message.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<Message> messages = [];
  bool isLoading = true;

  Future loadMessageList() async {
    List<Message> _messages = await Message.browse();
    setState(() {
      messages = _messages;
      isLoading = false;
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
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
