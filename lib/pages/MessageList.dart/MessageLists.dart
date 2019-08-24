import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mail_app_practise/pages/MessageList.dart/MessageList1.dart';
import 'package:mail_app_practise/pages/MessageList.dart/MessageList2.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class MessageLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Email App'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.refresh),
          //     onPressed: () {},
          //   )
          // ],
          bottom: TabBar(
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
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: <Widget>[
            MessageList1(),
            MessageList2(),
          ],
        ),
      ),
    );
  }
}
