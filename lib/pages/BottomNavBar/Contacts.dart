import 'package:flutter/material.dart';
import 'package:mail_app_practise/widgets/AppBar.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text('Contacts'),),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Contacts'),
      ),
    );
  }
}
