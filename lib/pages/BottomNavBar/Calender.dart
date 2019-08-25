import 'package:flutter/material.dart';
import 'package:mail_app_practise/widgets/AppBar.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text('Calender')),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Calender'),
      ),
    );
  }
}
