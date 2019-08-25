import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  final Text title;

  MyAppBar({this.title})
      : super(
          title: title,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            )
          ],
        );
}
