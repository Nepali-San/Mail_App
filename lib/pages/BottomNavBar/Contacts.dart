import 'package:flutter/material.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Contacts extends StatelessWidget {
  final ContactManager contactManager = ContactManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Chip(
              label: StreamBuilder<int>(
                  stream: contactManager.contactCounter,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? snapshot.data.toString() : '0',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  }),
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<Object>(
          stream: contactManager.contactList,
          builder: (context, snapshot) {
            List<String> contacts = snapshot.data;
            Widget w = snapshot.hasData
                ? Container(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        return Text(contacts[index]);
                      },
                      itemCount: contacts.length,
                    ),
                  )
                : Center(child: Text('No data here'));
            return w;
          }),
    );
  }
}
