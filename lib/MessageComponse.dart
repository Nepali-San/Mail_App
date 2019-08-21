import 'package:flutter/material.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Msg compose'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                "Compose New Message",
                style: Theme.of(context).textTheme.title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Love",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.pop(context, 'Love');
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Hate",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.brown,
                    onPressed: () {
                      Navigator.pop(context, 'Hate');
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
