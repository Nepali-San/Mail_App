import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mail_app_practise/pages/MessageCompose.dart';
import 'package:mail_app_practise/model/message.dart';

class ComposeBtn extends StatelessWidget {
  // final List<Message> messages;

  // ComposeBtn({this.messages});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(FontAwesomeIcons.pencilAlt, color: Colors.white),
      onPressed: () async {
        Message msg = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageCompose(),
          ),
        );

        if (msg != null) {
          // messages.add(msg);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Your message: ${msg.body}"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
    );
  }
}
