import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/streams/MessageFormManager.dart';
import 'package:mail_app_practise/model/message.dart';

class MessageCompose extends StatelessWidget {
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
                StreamBuilder<String>(
                  stream: messageFormManger.email$,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration: InputDecoration(
                        labelText: 'To',
                        errorText: snapshot.error,
                      ),
                      // * point-free style , parameter is implictly passed
                      onChanged: messageFormManger.setEmail,
                    );
                  },
                ),
                StreamBuilder<String>(
                    stream: messageFormManger.subject$,
                    builder: (context, snapshot) {
                      return TextField(
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          errorText: snapshot.error,
                        ),
                        onChanged: messageFormManger.setSubject,
                      );
                    }),
                Divider(
                  height: 60.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Body',
                  ),
                  maxLines: 5,
                  onChanged: messageFormManger.setBody,
                ),
                SizedBox(height: 10.0),
                StreamBuilder<bool>(
                    stream: messageFormManger.isFormValid$,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: !snapshot.hasData
                            ? null
                            : () {
                                Message msg = messageFormManger.submit();
                                Navigator.pop(context, msg);
                              },
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
