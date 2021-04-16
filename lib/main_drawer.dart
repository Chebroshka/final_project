import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
// Update the state of the app.
// ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
// Update the state of the app.
// ...
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
