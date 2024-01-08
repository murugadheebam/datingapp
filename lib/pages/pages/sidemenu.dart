import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search.dart';
import 'profile.dart';
import 'settings.dart';
import 'majorissues.dart';

final userNameProvider = StateProvider<String?>((ref) => null);

class Sidemenu extends ConsumerWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                  backgroundImage: AssetImage('assets/profile.png'),
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
            title: SidemenuItem(menuText: "Dashboard"),
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
            title: SidemenuItem(menuText: "Search"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Search()), // Replace YourDestinationPage with the page you want to navigate to
              );
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
            title: SidemenuItem(menuText: "My Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Profile()), // Replace YourDestinationPage with the page you want to navigate to
              );
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
            title: SidemenuItem(menuText: "Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
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
            title: SidemenuItem(menuText: 'Raise Major Issues'),
            onTap: () {
              // Add functionality here when item 2 is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Majorissues()),
              );
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
            title: SidemenuItem(menuText: "App Feedback"),
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

class SidemenuItem extends StatelessWidget {
  final menuText;
  const SidemenuItem({
    super.key,
    required this.menuText
  });

  @override
  Widget build(BuildContext context) {
    return Text(menuText, style: TextStyle(fontWeight: FontWeight.w600));
  }
}
