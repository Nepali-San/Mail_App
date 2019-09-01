import 'package:flutter/material.dart';

class Observer<T> extends StatelessWidget {
  @required
  final Stream<T> stream;

  @required
  final Function onSuccess;

  final Function onError;

  Observer({this.onError, this.onSuccess, this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context,AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return onError(context, snapshot.error);
        }
        if (snapshot.hasData) {
          return onSuccess(context, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
