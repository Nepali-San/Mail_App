import 'dart:async';

import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/services/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  ContactManager() {
    _filterSubject.stream.listen(
      (filter) async {
        var contacts = await ContactService.browse(query: filter);
        _collectionSubject.add(contacts);
      },
    );

    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<int> _countSubject = PublishSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject =
      PublishSubject<List<Contact>>();

  // * Sink and Streams/Observable are the interfaces for StreamBuilder.
  Sink<String> get inFilter => _filterSubject.sink;
  Observable<int> get count$ => _countSubject.stream;
  Observable<List<Contact>> get browse$ => _collectionSubject.stream;

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}
