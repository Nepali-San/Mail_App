import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/Streams/CounterManager.dart';

class Overseer {
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(ContactManager, ContactManager());
    register(CounterManager, CounterManager());
  }

  register(name, object) => repository[name] = object;

  fetch({name}) => repository[name];
}
