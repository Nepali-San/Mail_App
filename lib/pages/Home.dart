import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Calender.dart';
import 'package:mail_app_practise/pages/BottomNavBar/ContactSearchDelegate.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Contacts.dart';
import 'package:mail_app_practise/pages/BottomNavBar/InboxTabs/InboxTabs.dart';
import 'package:mail_app_practise/widgets/AppBar.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> appbarTitles = ['Index', 'Contacts', 'Calender'];

  @override
  Widget build(BuildContext context) {
    List<Widget> appbarActions = [
      Container(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.refresh),
      ),
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(),
              );
            },
          ),
          ContactCounterChip(),
        ],
      ),
      Container(),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          index: _selectedIndex,
          title: Text(appbarTitles[_selectedIndex]),
          appbarIcons: appbarActions,
        ),
        body: [
          InboxTabs(),
          Contacts(),
          Calender(),
        ].elementAt(_selectedIndex),
        drawer: AppDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text("Inbox"), icon: Icon(Icons.mail)),
            BottomNavigationBarItem(
                title: Text("Contacts"), icon: Icon(Icons.people)),
            BottomNavigationBarItem(
                title: Text("Calender"), icon: Icon(Icons.calendar_today))
          ],
          onTap: _onTapHandler,
          currentIndex: _selectedIndex,
        ),
        floatingActionButton: _selectedIndex == 2 ? FAB() : null,
      ),
    );
  }

  void _onTapHandler(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
