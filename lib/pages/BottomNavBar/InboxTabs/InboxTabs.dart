import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mail_app_practise/pages/BottomNavBar/InboxTabs/MessageList.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class InboxTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            )
          ],
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
            MessageList(
              status: 'important',
            ),
            MessageList(
              status: 'others',
            ),
          ],
        ),
      ),
    );
  }
}
