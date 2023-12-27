import 'package:flutter/material.dart';

// Create a separate Drawer widget
class Sidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Add functionality here when item 1 is tapped
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Add functionality here when item 2 is tapped
            },
          ),
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}
