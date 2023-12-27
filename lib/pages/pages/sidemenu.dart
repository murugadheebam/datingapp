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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/user.png'),
                  backgroundColor: Colors.transparent,
                  // Placeholder image for demonstration (replace with your image)
                ),
                SizedBox(height: 8),
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child: Image.asset('assets/dashboard.png', width: 24, height: 24),
            ),
            title: Text('Dashboard'),
            onTap: () {
              // Add functionality here when item 1 is tapped
            },
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child: Image.asset('assets/search.png', width: 24, height: 24),
            ),
            title: Text('Search'),
            onTap: () {
              // Add functionality here when item 2 is tapped
            },
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child: Image.asset('assets/user.png', width: 24, height: 24),
            ),
            title: Text('My Profile'),
            onTap: () {
              // Add functionality here when item 2 is tapped
            },
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child: Image.asset('assets/settings.png', width: 24, height: 24),
            ),
            title: Text('Settings'),
            onTap: () {
              // Add functionality here when item 2 is tapped
            },
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child:
                  Image.asset('assets/exclamation.png', width: 24, height: 24),
            ),
            title: Text('Raise Major Issues'),
            onTap: () {
              // Add functionality here when item 2 is tapped
            },
          ),
          ListTile(
            leading: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color(0xFFff0068), // Convert hexadecimal to Color

                BlendMode.srcIn,
              ),
              child: Image.asset('assets/review.png', width: 24, height: 24),
            ),
            title: Text('App Feedback'),
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
