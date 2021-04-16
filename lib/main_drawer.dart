import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/girls_PNG6474.png'),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Jane Dow',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight + Alignment(0, .3),
                  child: Text(
                    'jane.dow@email.com',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed(routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_outlined),
            title: Text('Charts'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed(routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed(routeName);
            },
          ),
        ],
      ),
    );
  }
}
