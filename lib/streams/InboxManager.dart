import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/services/MessageService.dart';
import 'package:rxdart/rxdart.dart';

class InboxManager {
  InboxManager() {
    _inStatusFilter.stream.listen((String status) async {
      List<Message> messages = await MessageService.browse(status: status);
      _publishSubject.add(messages);
    });
  }

  final PublishSubject<String> _inStatusFilter = PublishSubject<String>();
  void setStatus(value) {
    _inStatusFilter.sink.add(value);
  }

  /*
   ? Is there any way to get string (through stream) and output a List (through sink) using a single subject ?
   ? May be a streamTransformer will work
   */

  final PublishSubject<List<Message>> _publishSubject =
      PublishSubject<List<Message>>();

  Observable<List<Message>> get msgStream$ => _publishSubject.stream;

  void dispose() {
    _inStatusFilter.close();
    _publishSubject.close();
  }
}
