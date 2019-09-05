import 'dart:async';

import 'package:mail_app_practise/helpers/validateEmail.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:rxdart/rxdart.dart';

class MessageFormManger with Validation {
  final _email = BehaviorSubject<String>.seeded('');
  Stream<String> get email$ => _email.stream.transform(validateEmail);
  // Sink<String> get inemail => _email.sink;
  // * we may expose a function instread of sink.
  void setEmail(String value) => _email.sink.add(value);

  final _subject = BehaviorSubject<String>.seeded('');
  Stream<String> get subject$ => _subject.stream.transform(validateSubject);  
  void setSubject(String value) => _subject.sink.add(value);

  final _body = BehaviorSubject<String>.seeded('');
  Stream<String> get body$ => _body.stream;  
  void setBody(String value) => _body.sink.add(value);

  // * if all 3 stream return a value , then form is error-free
  // * combineLatest will wait for all 3 streams to pass value and then return true if valid

  Stream<bool> get isFormValid$ =>
      Observable.combineLatest([email$, body$, subject$], (values) => true);

  Message submit() {
    String subject = _subject.value;
    String body = _body.value;
    return Message(subject: subject, body: body);
  }

  void dispose() {
    _email.close();
    _subject.close();
    _body.close();
  }
}
