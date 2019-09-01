import 'package:flutter/material.dart';

// * this class just simplifies the streamBuilder;

class Observer<T> extends StatelessWidget {
  Observer({this.onError, this.onSuccess, this.stream, this.onWaiting});

  @required
  final Stream<T> stream;

  @required
  final Function onSuccess;

  // * we have defualt function if these optional functions are null,
  final Function onError, onWaiting;

  // * these are the default functions.
  Function get _defaultOnWaiting =>
      (context) => Center(child: CircularProgressIndicator());

  Function get _defaultOnError => (context, error) => Text(error);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return onSuccess(context, snapshot.data);
        } else if (snapshot.hasError) {
          return onError != null
              ? onError(context, snapshot.error)
              : _defaultOnError(context, snapshot.error);
        } else {
          return onWaiting != null
              ? onWaiting(context)
              : _defaultOnWaiting(context);
        }
      },
    );
  }
}
