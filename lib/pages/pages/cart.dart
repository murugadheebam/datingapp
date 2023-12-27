import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          backgroundColor: Color(0xFF025091),
        ),
        body: Center(
          child: Text('Statistics'),
        ),
      ),
    );
  }
}
