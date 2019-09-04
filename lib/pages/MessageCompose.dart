import 'package:flutter/material.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/widgets/Observer.dart';
import 'package:rxdart/rxdart.dart';

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
                Observer(
                  // * a dummy stream can be generated using Observable.just() &
                  // * Observable.error('error msg') for error stream
                  // * here we will validate and save data using reactive concept
                  stream: Observable.just("data"),
                  onSuccess: (BuildContext context, String data) {
                    return TextField(                      
                      decoration: InputDecoration(
                        labelText: 'To',
                      ),
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
