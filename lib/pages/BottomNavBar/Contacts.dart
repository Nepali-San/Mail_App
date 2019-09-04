import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/widgets/ContactListBuilder.dart';
import 'package:mail_app_practise/widgets/Observer.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    ContactManager contactManager = overseer.fetch(name: ContactManager);
    contactManager.inFilter.add('');

    return ContactListBuilder(
      stream: contactManager.browse$,
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
}

class ContactCounterChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    ContactManager contactManager = overseer.fetch(name: ContactManager);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Observer<int>(
          stream: contactManager.count$,
          onSuccess: (BuildContext context, int data) {
            return Chip(
              label: Text(
                (data ?? 0).toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            );
          }),
    );
  }
}
