import 'dart:async';

import 'package:rxdart/rxdart.dart';

class MessageFormManger {
  final _emailSubject = BehaviorSubject<String>.seeded('@');
  // ? @ will help to remove error text , in initial loading of form.
  // ! but now it will pass the email validation for err case, if not typed anything in field

  Stream<String> get email$ => _emailSubject.stream.transform(validateEmail);
  Sink<String> get inemail => _emailSubject.sink;

  // * simple validation
  static bool isEmail(String email) => email.contains('@');

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink) {
    if (isEmail(value)) {
      sink.add(value);
    } else {
      sink.addError("Email is not valid !!!");
    }
  });

  void dispose() {
    _emailSubject.close();
  }
}
