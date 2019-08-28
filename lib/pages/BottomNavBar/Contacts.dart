import 'package:flutter/material.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/pages/BottomNavBar/ContactSearchDelegate.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';
import 'package:mail_app_practise/widgets/ContactCounterChip.dart';
import 'package:mail_app_practise/widgets/ContactListBuilder.dart';

class Contacts extends StatelessWidget {
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
                delegate: ContactSearchDelegate(),
              );
            },
          ),
          ContactCounterChip()
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
