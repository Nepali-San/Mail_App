import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/services/MessageService.dart';
import 'package:rxdart/rxdart.dart';

class InboxManager {
  InboxManager(){
    inStatusFilter.stream.listen((String status) async {
      List<Message> future = await MessageService.browse(status: status);
      _publishSubject.add(future);
    });
  }

  final PublishSubject<String> inStatusFilter = PublishSubject<String>();

  final PublishSubject<List<Message>> _publishSubject =
      PublishSubject<List<Message>>();  

  Observable<List<Message>> get msgStream$ => _publishSubject.stream;  

  void dispose(){
    inStatusFilter.close();
    _publishSubject.close();
  }
}
