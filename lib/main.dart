import 'package:flutter/material.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/ContactManager.dart';
import 'package:mail_app_practise/pages/Home.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: ContactManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
        ),
        //MessageLists widget contains tab with two different pages.
        home: Home(),
      ),
    );
  }
}
