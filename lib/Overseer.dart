import 'package:mail_app_practise/Streams/ContactManager.dart';

class Overseer {
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(ContactManager, ContactManager());
  }

  register(name, object) => repository[name] = object;

  fetch({name}) => repository[name];
}
