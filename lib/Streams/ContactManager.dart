import 'dart:async';

import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/services/ContactService.dart';

class ContactManager {
  //this stream will return a list of contacts
  Stream<List<Contact>> get contactList async* {
    yield await ContactService.browse();
  }

  //this streamController is used for providing method to listen for changes in above stream
  StreamController<int> _contactController = StreamController<int>();

  //this stream will return stream added to the controller.
  Stream<int> get contactCounter => _contactController.stream;

  ContactManager() {
    //we listent to the contactList and whenever it changes we add a data
    //to another stream through controller.
    contactList.listen((list) => _contactController.add(list.length));
  }
}
