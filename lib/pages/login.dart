import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';
import 'pages/dashboard.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF6a9739),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
              ),
            ),
            SizedBox(
              height: 20, // Add more height here for additional space
            ),
            SizedBox(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gmail',
                ),
              ),
            ),
            SizedBox(
              height: 20, // Add more height here for additional space
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(
              height: 20, // Add more height here for additional space
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Register()), // Replace SignUp() with your signup page
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}
