import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/BottomNavBar/InboxTabs/MessageList.dart';

class InboxTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        MessageList(
          status: 'important',
        ),
        MessageList(
          status: 'others',
        ),
      ],
    );
  }
}
