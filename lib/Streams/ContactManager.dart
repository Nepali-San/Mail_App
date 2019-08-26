import 'dart:async';

List<String> CONTACTS = ['user1', 'user2', 'user3', 'user4', 'user5'];

class ContactManager {
  //this stream will return a list of contacts
  Stream<List<String>> get contactList async* {
    for (var i = 0; i < CONTACTS.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield (CONTACTS.sublist(0, i + 1));
    }
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
