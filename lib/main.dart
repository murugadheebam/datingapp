import 'package:datingapp/pages/pages/otp.dart';
import 'package:datingapp/pages/pages/search.dart';
import 'package:datingapp/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/pages/provider.dart';
import 'pages/pages/dashboard.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: MyApp(),
  ));
}

// class MyApp extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       title: 'Splash Screen Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Home(),
//     );
//   }
// }

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(isLoggedInProvider);
    print('loggedIn: $loggedIn');

    if (loggedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Search(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      );
    }
  }
}
