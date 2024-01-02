import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'createevent.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        drawer: Sidemenu(),
        body: Column(children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const Createevent()), // Replace SignUp() with your signup page
              );
            },
            child: const Text(
              'Create Event',
              style: TextStyle(color: Colors.black54, fontSize: 16),
            ),
          )
        ]));
  }
}
