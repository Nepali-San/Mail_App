import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/services/MessageService.dart';
import 'package:rxdart/rxdart.dart';

class InboxManager {
  InboxManager() {
    inStatusFilter.stream.listen((String status) async {
      List<Message> future = await MessageService.browse(status: status);
      _publishSubject.add(future);
    });
  }

  final PublishSubject<String> inStatusFilter = PublishSubject<String>();

  /*
   ? instead of using two subjects , one for getting i/p and another for o/p
   ? we can use single subject to get our i/p and use 'transformstream' to get desired o/p.
   */

  final PublishSubject<List<Message>> _publishSubject =
      PublishSubject<List<Message>>();

  Observable<List<Message>> get msgStream$ => _publishSubject.stream;

  void dispose() {
    inStatusFilter.close();
    _publishSubject.close();
  }
}
