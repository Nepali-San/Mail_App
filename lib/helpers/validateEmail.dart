import 'dart:async';

// * SingleResponsibility : Any modules including managers should have single responsibility.
// * Manager should have responsibilty of managing streams only, not validating.
// * hence we seprate our validation login as a mixin(special class).
// * other classes can use mixins without inheriting it.

mixin Validation {
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

  final validateSubject = StreamTransformer<String, String>.fromHandlers(
      handleData: (String value, EventSink<String> sink) {
    if (value.length == 0) {
      sink.addError("Subject cannot be empty");
    } else if (value.length < 5) {
      sink.addError("Subject must contain atleast 5 characters.");
    } else {
      sink.add(value);
    }
  });
}
