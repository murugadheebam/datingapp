import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Daily'),
          backgroundColor: Color(0xFF6a9739),
        ),
        body: Center(
          child: Text('Notifications'),
        ),
      ),
    );
  }
}
