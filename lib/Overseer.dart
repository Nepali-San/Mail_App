import 'package:mail_app_practise/streams/ContactManager.dart';
import 'package:mail_app_practise/streams/CounterManager.dart';
import 'package:mail_app_practise/streams/InboxManager.dart';
import 'package:mail_app_practise/streams/MessageFormManager.dart';

/*
 * Overseer contains maps of all the streams 
 * hence by passing overseer as provider data , 
 * we can access all the managers/stream.
 */

class Overseer {
  Map<dynamic, dynamic> repository = {};

  Overseer() {
    register(ContactManager, ContactManager());
    register(CounterManager, CounterManager());
    register(InboxManager, InboxManager());
    register(MessageFormManger, MessageFormManger());
  }

  register(name, object) => repository[name] = object;

  fetch({name}) => repository[name];
}
