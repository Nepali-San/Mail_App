import 'package:flutter/material.dart';
import 'package:mail_app_practise/DirtyProvider.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/pages/Home.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Overseer>(
      data: Overseer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
        ),
        //DirtyProvider has it's data on it's own state,
        home: DirtyProvider(
          child: Home(),
        ),
      ),
    );
  }
}
