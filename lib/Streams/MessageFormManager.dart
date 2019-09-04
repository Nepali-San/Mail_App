import 'dart:async';

import 'package:mail_app_practise/helpers/validateEmail.dart';
import 'package:rxdart/rxdart.dart';

class MessageFormManger with EmailValidation {
  final _emailSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get email$ => _emailSubject.stream.transform(validateEmail);
  Sink<String> get inemail => _emailSubject.sink;

  void dispose() {
    _emailSubject.close();
  }
}
