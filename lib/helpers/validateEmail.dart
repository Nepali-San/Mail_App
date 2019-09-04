import 'dart:async';

// * SingleResponsibility : Any modules including managers should have single responsibility.
// * Manager should have responsibilty of managing streams only, not validating.
// * hence we seprate our validation login as a mixin(special class).
// * other classes can use mixins without inheriting it.

mixin EmailValidation {
  // * simple validation logic
  static bool isEmail(String email) => email.contains('@');

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink) {
    if (isEmail(value)) {
      sink.add(value);
    } else {
      sink.addError("Email is not valid !!!");
    }
  });
}
