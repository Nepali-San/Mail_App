import 'package:flutter/material.dart';
import 'package:mail_app_practise/Overseer.dart';
import 'package:mail_app_practise/Provider.dart';
import 'package:mail_app_practise/streams/CounterManager.dart';
import 'package:mail_app_practise/widgets/Observer.dart';

class Calender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Counter(),
    );
  }
}

class IncrementBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    CounterManager counterManager = overseer.fetch(name: CounterManager);

    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      onPressed: counterManager.increment,
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Overseer overseer = Provider.of(context);
    CounterManager counterManager = overseer.fetch(name: CounterManager);

    return Observer<int>(
      stream: counterManager.counter$,
      onSuccess: (context, data) {
        return Text('Calender $data');
      },
    );
  }
}
