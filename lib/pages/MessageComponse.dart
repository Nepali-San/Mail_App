import 'package:flutter/material.dart';
import 'package:mail_app_practise/model/message.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to, body, subject;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Msg compose'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onSaved: (value) => to = value,
                  decoration: InputDecoration(
                    labelText: 'To',
                  ),
                ),
                TextFormField(
                  onSaved: (value) => subject = value,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                Divider(
                  height: 60.0,
                ),
                TextFormField(
                  onSaved: (value) => body = value,
                  decoration: InputDecoration(hintText: 'Body'),
                  maxLines: 5,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    this.key.currentState.save();
                    Message msg = Message(body: body, subject: subject);                    
                    Navigator.pop(context, msg);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
