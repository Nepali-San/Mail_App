import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/MessageFormManager.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/widgets/Observer.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  String to, body, subject;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MessageFormManger messageFormManger =
        Provider.of<Overseer>(context).fetch(name: MessageFormManger);

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
                Observer(
                  stream: messageFormManger.email$,
                  onSuccess: (BuildContext context, String data) {
                    return TextField(
                      decoration: InputDecoration(
                        labelText: 'To',
                      ),
                      // * point-free style , parameter is implictly passed
                      onChanged: messageFormManger.inemail.add,
                    );
                  },
                  onError: (BuildContext context, String err) {
                    return TextField(
                      decoration: InputDecoration(
                        labelText: 'To',
                        errorText: err,
                      ),
                    );
                  },
                ),
                TextFormField(
                  validator: (value) => value.length < 6
                      ? "Must have more than 5 characters"
                      : null,
                  onSaved: (value) => subject = value,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                  ),
                ),
                Divider(
                  height: 60.0,
                ),
                TextFormField(
                  validator: (value) => value.length < 6
                      ? "Must have more than 5 characters"
                      : null,
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
                    if (this.key.currentState.validate()) {
                      this.key.currentState.save();
                      Message msg = Message(body: body, subject: subject);
                      Navigator.pop(context, msg);
                    }
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
