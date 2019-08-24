import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('123here.comes.san@gmail.com'),
            accountName: Text('San Neupane'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://i.pinimg.com/originals/a5/76/46/a576463a3b5a9e8cb2a22b47c45a6a7f.jpg",
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.inbox),
            title: Text(
              'Inbox',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Chip(
              label: Text('11', style: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: Colors.blue[100],
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.userEdit),
            title: Text(
              'Draft',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.archive),
            title: Text(
              'Archive',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.paperPlane),
            title: Text(
              'Sent',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trash),
            title: Text(
              'Trash',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
