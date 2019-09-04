import 'package:rxdart/rxdart.dart';

class MessageFormManger {
  MessageFormManger() {
    _emailSubject.listen((value) => print(value));
  }

  final _emailSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get email$ => _emailSubject.stream;
  Sink<String> get inemail => _emailSubject.sink;

  void dispose() {
    _emailSubject.close();
  }
}
