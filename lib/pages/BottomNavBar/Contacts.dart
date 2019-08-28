import 'package:flutter/material.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/pages/BottomNavBar/ContactSearchDelegate.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';
import 'package:mail_app_practise/widgets/ContactListBuilder.dart';

class Contacts extends StatelessWidget {
  // final ContactManager contactManager = ContactManager();

  @override
  Widget build(BuildContext context) {

    ContactManager contactManager = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(contactManager: contactManager),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Chip(
              label: StreamBuilder<int>(
                  stream: contactManager.contactCounter,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
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
      body: ContactListBuilder(
        stream: contactManager.contactList,
        builder: (BuildContext context, List<Contact> data) {
          List<Contact> contacts = data;
          return Container(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index].name),
                  leading: CircleAvatar(
                    child: Text(contacts[index].name[0]),
                  ),
                  subtitle: Text(contacts[index].email),
                );
              },
              itemCount: contacts.length,
            ),
          );
        },
      ),
    );
  }
}
