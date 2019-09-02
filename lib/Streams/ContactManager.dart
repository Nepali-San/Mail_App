import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/services/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  ContactManager() {
    // * listen to the data from inFiter and provide it to collectionSubject
    // * '.stream' can be omitted in below line of code
    _filterSubject.stream.listen(
      (query) async {
        var contacts = await ContactService.browse(query: query);
        // * '.sink' can be omitted in below line of code
        _collectionSubject.sink.add(contacts);
      },
    );

    // * Listen data on CollectionSubject and provide to CountSubject, '.stream' is omitted here
    _collectionSubject.listen((list) => _countSubject.sink.add(list.length));
  }

  // * we get input from outside using _filterSubject's Sink only.
  final PublishSubject<String> _filterSubject = PublishSubject<String>();

  // * filterSubject adds data to collectionSubject through listener.
  final PublishSubject<List<Contact>> _collectionSubject =
      PublishSubject<List<Contact>>();

  // * collectionSubject adds data to countSubject through listener.
  final PublishSubject<int> _countSubject = PublishSubject<int>();

  // * Sink and Streams/Observable are the interfaces for StreamBuilder/Subjects.

  // * inFilter provides interface for our input i.e. query for contacts fetching
  Sink<String> get inFilter => _filterSubject.sink;

  // * Observable like stream provides the data added to it's sink.
  Observable<int> get count$ => _countSubject.stream;
  Observable<List<Contact>> get browse$ => _collectionSubject.stream;

  // * dispose the subjects to avoid mem. leaks
  void dispose() {
    _countSubject.close();
    _filterSubject.close();
    _collectionSubject.close();
  }
}

/*
  * PublishSubject is like StreamController but  we can listen
  * for stream multiple times without creating new Objects.
  */
