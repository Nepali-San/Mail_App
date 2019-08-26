import 'package:flutter/material.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';
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
      body: StreamBuilder<List<Contact>>(
        stream: contactManager.contactList,
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('There is an error : ${snapshot.error}'),
                );
              }
              List<Contact> contacts = snapshot.data;
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
              break;
            default:
              return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
