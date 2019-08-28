import 'package:flutter/material.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/model/contacts.dart';

class ContactListBuilder extends StatelessWidget {
  ContactListBuilder({
    @required this.builder,
  });

  final Function builder;

  @override
  Widget build(BuildContext context) {
    ContactManager contactManager = Provider.of(context);

    return StreamBuilder<List<Contact>>(
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
            return builder(context, snapshot.data);
            break;
          default:
            return Text('Something went wrong');
        }
      },
    );
  }
}
