import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/widgets/ContactListBuilder.dart';

class ContactSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Center(
        child: Text('Type atleast 3 character to perform search'),
      );
    }

    Overseer overseer = Provider.of(context);
    ContactManager contactManager = overseer.fetch(name: ContactManager);

    // * ContactListBuilder handles the different connection states of streams
    return ContactListBuilder(
      stream: contactManager.browse$(query: query),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
