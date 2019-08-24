import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/MessageList.dart/MessageLists.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlueAccent,
      ),
      //MessageLists widget contains tab with two different pages.
      home: MessageLists(),
    );
  }
}
