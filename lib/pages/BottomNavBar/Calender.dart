import 'package:flutter/material.dart';
import 'package:mail_app_practise/DirtyProvider.dart';
import 'package:mail_app_practise/widgets/AppBar.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text('Calender')),
      drawer: AppDrawer(),
      body: Center(
        child: Counter(),
      ),
      floatingActionButton: FAB(),
    );
  }
}

class FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = DirtyProvider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: state.increment,
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = DirtyProvider.of(context);
    var counter = state.counter;

    return Text('Calender $counter');
  }
}
