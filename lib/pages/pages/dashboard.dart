import 'package:flutter/material.dart';
import 'sidemenu.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Sidemenu(),
      body: Center(
        child: Text('This is the Home Page'),
      ),
    );
  }
}
