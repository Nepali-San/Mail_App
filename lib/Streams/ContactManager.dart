import 'dart:async';

import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/services/ContactService.dart';

class ContactManager {
  ContactManager() {
    //we listent to the contactList and whenever it changes we add a data
    //to another stream through controller.
    contactList.listen((list) => _contactController.add(list.length));
  }

  //this stream will return a list of contacts
  // Stream<List<Contact>> get contactList async* {
  //   yield await ContactService.browse();
  // }

  //instead of above (yield await) method we can use this short form...
  Stream<List<Contact>> get contactList {
    return Stream.fromFuture(ContactService.browse());
  }

  //this streamController is used for providing method to listen for changes in above stream
  StreamController<int> _contactController = StreamController<int>();

  //this stream will return stream added to the controller.
  Stream<int> get contactCounter => _contactController.stream;

  //stream to return the filtered collection of contacts.
  Stream<List<Contact>> filteredContactList({query}) {
    return Stream.fromFuture(ContactService.browse(query: query));
  }
}
