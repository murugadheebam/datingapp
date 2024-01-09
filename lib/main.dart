import 'package:datingapp/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(ProviderScope(child: LoginApp()));
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink.shade400,
          primary: Colors.pink
        )
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
