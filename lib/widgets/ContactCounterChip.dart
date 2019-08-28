import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';

class ContactCounterChip extends StatelessWidget {   

  @override
  Widget build(BuildContext context) {

    ContactManager contactManager = Provider.of(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Chip(
        label: StreamBuilder<int>(
            stream: contactManager.contactCounter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data.toString() : '0',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }),
        backgroundColor: Colors.red,
      ),
    );
  }
}
