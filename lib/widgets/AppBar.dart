import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppBar extends AppBar {
  final Text title;
  final appbarIcons;
  final int index;  

  MyAppBar({this.title, this.appbarIcons, this.index})
      : super(
          title: title,
          actions: <Widget>[
            appbarIcons[index],
          ],
          bottom: index != 0
              ? null
              : TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: "Important",
                      icon: Icon(FontAwesomeIcons.shippingFast),
                    ),
                    Tab(
                      text: "Others",
                      icon: Icon(FontAwesomeIcons.random),
                    ),
                  ],
                ),
        );
}
