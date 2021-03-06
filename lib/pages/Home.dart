import 'package:flutter/material.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Calender.dart';
import 'package:mail_app_practise/pages/BottomNavBar/ContactSearchDelegate.dart';
import 'package:mail_app_practise/pages/BottomNavBar/Contacts.dart';
import 'package:mail_app_practise/pages/BottomNavBar/InboxTabs/InboxTabs.dart';
import 'package:mail_app_practise/widgets/AppBar.dart';
import 'package:mail_app_practise/widgets/AppDrawer.dart';
import 'package:mail_app_practise/widgets/ComposeBtn.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> appbarTitles = ['Inbox', 'Contacts', 'Calender'];

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

    Widget floatingBtn = Container();
    if (_selectedIndex == 0) {
      floatingBtn = ComposeBtn();
    } else if (_selectedIndex == 2) {
      floatingBtn = IncrementBtn();
    }

    /*
     * Since we will have one bottomNavPage with a Tab so we use DefaultTabController
     * You must put all bottom nav pages or tab pages nested under the same Scaffold.
     */

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /*  
         * This appbar will conditionally change based on the current page of 
         * bottomNavbar  
         * */
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
              title: Text("Inbox"),
              icon: Icon(Icons.mail),
            ),
            BottomNavigationBarItem(
              title: Text("Contacts"),
              icon: Icon(Icons.people),
            ),
            BottomNavigationBarItem(
              title: Text("Calender"),
              icon: Icon(Icons.calendar_today),
            )
          ],
          onTap: _onTapHandler,
          currentIndex: _selectedIndex,
        ),
        floatingActionButton: floatingBtn,
      ),
    );
  }

  void _onTapHandler(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
