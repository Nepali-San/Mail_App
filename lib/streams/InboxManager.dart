import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/services/MessageService.dart';
import 'package:rxdart/rxdart.dart';

class InboxManager {
  InboxManager() {
    _filterStatus.stream.listen((String status) async {
      List<Message> messages = await MessageService.browse(status: status);
      _messageList.add(messages);
    });
  }

  final PublishSubject<String> _filterStatus = PublishSubject<String>();
  void setStatus(value) {
    _filterStatus.sink.add(value);
  }

  /*
   ? Is there any way to get string (through stream) and output a List (through sink) using a single subject ?
   ? May be a streamTransformer will work
   */

  final PublishSubject<List<Message>> _messageList =
      PublishSubject<List<Message>>();

  Observable<List<Message>> get msgStream$ => _messageList.stream;

  void dispose() {
    _filterStatus.close();
    _messageList.close();
  }
}
