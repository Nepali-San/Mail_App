import 'package:flutter/material.dart';
import 'package:mail_app_practise/model/contacts.dart';
import 'package:mail_app_practise/widgets/Observer.dart';

class ContactListBuilder extends StatelessWidget {
  ContactListBuilder({
    @required this.stream,
    @required this.builder,
  });

  final Stream<List<Contact>> stream;
  final Function builder;

  @override
  Widget build(BuildContext context) {
    return Observer<List<Contact>>(
      stream: stream,
      onSuccess: (BuildContext context, List<Contact> data) =>
          builder(context, data),
      onError: (context, error) => Center(
        child: Text('There is an error : $error'),
      ),
      onWaiting: (context) => LinearProgressIndicator(
        backgroundColor: Colors.red,
      ),
    );
  }
}
