import 'dart:async';

import 'package:mail_app_practise/helpers/validateEmail.dart';
import 'package:mail_app_practise/model/message.dart';
import 'package:rxdart/rxdart.dart';

class MessageFormManger with Validation {
  final _email = BehaviorSubject<String>.seeded('');
  Stream<String> get email$ => _email.stream.transform(validateEmail);
  // Sink<String> get inemail => _email.sink;
  // * we may expose a function instead of sink.
  void setEmail(String value) => _email.sink.add(value);

  final _subject = BehaviorSubject<String>.seeded('');
  Stream<String> get subject$ => _subject.stream.transform(validateSubject);
  void setSubject(String value) => _subject.sink.add(value);

  final _body = BehaviorSubject<String>.seeded('');
  Stream<String> get body$ => _body.stream;
  void setBody(String value) => _body.sink.add(value);

  // * if all 3 stream return a value , then form is error-free
  // * combineLatest will wait for all 3 streams to pass value and then return true if valid

  // ! Debug the combineLatest ...
  Stream<bool> get isFormValid$ =>
      Observable.combineLatest([email$, subject$, body$], (values) {
        // * values[3] are the list of latest valid values
        // * If the current value is error then latest values won't be affected
        // * current values may not be on values[3] if current values are error values
        // * i.e. Holds the latest valid value not latest error values.

        String _cemail = values[0];
        String _csubject = values[1];
        String _cbody = values[2];

        // * values that combineLatest has.
        print('latest valid values : [$_cemail] [$_csubject] [$_cbody]');

        // * values that was typed currently.
        print(
            'real values : [${_email.value}] [${_subject.value}] [${_body.value}] ');

        // * if fields are not filled , combineLatest has to wait and returns null.

        // * if combineLatest's have datas and they are equal to current datas, return true
        // * because our current typed data's are updated on combineLatest only when they are true.

        // * if not equal, combineLatest have lagged datas
        // * lagged datas are previous correct datas becoz combineLatest only stores when correct
        // * but our current datas have errors so it is not updated in combinLatest 
        // * so having lagged datas means incorrect so return false

        return (_cemail == _email.value &&
            _csubject == _subject.value &&
            _cbody == _body.value);
      });

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
