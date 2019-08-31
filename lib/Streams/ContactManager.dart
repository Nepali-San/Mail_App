import 'dart:async';

import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/services/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  ContactManager() {
    //we listent to the contactList and whenever it changes we add a data
    //to another stream through controller.
    browse$().listen((list) => _contactController.add(list.length));
  }

  //this streamController is used for providing method to listen for changes in above stream
  //instead of streamController , use BehaviorSubject to listen for changes multiple times
  StreamController<int> _contactController = BehaviorSubject<int>();

  //this stream will return stream added to the controller.
  //$ added in end is just a convenction to tell this stream is exposed out.
  Stream<int> get count$ => _contactController.stream;

  //it returns the stream of list, we listens for change in this stream.
  Stream<List<Contact>> browse$({String query}) {
    return Stream.fromFuture(ContactService.browse(query: query));
  }
}
