import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/Streams/CounterManager.dart';
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
    Overseer overseer = Provider.of(context);
    CounterManager counterManager = overseer.fetch(name: CounterManager);

    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: counterManager.increment,
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    CounterManager counterManager = overseer.fetch(name: CounterManager);

    return StreamBuilder<int>(
      initialData: 0,
      stream: counterManager.counter$,
      builder: (context, snapshot) {
        return Text('Calender ${snapshot.data}');
      },
    );
  }
}
