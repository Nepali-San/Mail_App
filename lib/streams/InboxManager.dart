import 'package:mail_app_practise/model/message.dart';
import 'package:mail_app_practise/services/MessageService.dart';
import 'package:rxdart/rxdart.dart';

class InboxManager {
  InboxManager() {
    // ! quickly switching the tabs will fetch wrong list...
    _filterStatus.stream.listen((String status) async {
      List<Message> messages = await MessageService.browse(status: status);
      _messageList.add(messages);
    });
  }

  // * this will get our event/input.
  final PublishSubject<String> _filterStatus = PublishSubject<String>();
  void setStatus(value) {
    _filterStatus.sink.add(value);
  }  

  // * this will return list of message as state/output.
  final PublishSubject<List<Message>> _messageList =
      PublishSubject<List<Message>>();

  Observable<List<Message>> get msgStream$ => _messageList.stream;

  void dispose() {
    _filterStatus.close();
    _messageList.close();
  }
}

/*
   ? Is there any way to get string (through stream) and output a List (through sink) using a single subject ?
   ? May be a streamTransformer will work

   * no, having a single controller/subject will create a loop : 
   * we will have to get input and listen the input to give new appropriate ouput
   * on giving the new output we again listen to it as new input to give new appropriate output and it continues.
   * 
   * Also single controller can't be of different type , we will need two controller
   * one for the input(event) and other for the output(state)
   * then we listen to eventcontroller and map it to the statecontroller as like above.
   */