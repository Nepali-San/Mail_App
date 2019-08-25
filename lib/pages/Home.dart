import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Calender.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Contacts.dart';
import 'package:mail_app_practise/pages/BottomNavBar/InboxTabs/InboxTabs.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Email App'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
      body: [
        InboxTabs(),
        Contacts(),
        Calender(),
      ].elementAt(_selectedIndex),
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Inbox"), icon: Icon(Icons.mail)),
          BottomNavigationBarItem(
              title: Text("Contacts"), icon: Icon(Icons.people)),
          BottomNavigationBarItem(
              title: Text("Calender"), icon: Icon(Icons.calendar_today))
        ],
      ),
    );
  }
}
