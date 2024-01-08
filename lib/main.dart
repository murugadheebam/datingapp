import 'package:datingapp/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/pages/provider.dart';
import 'pages/pages/dashboard.dart';
import 'pages/login.dart';
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
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(isLoggedInProvider); 
      print('loggedIn: $loggedIn');

    if (loggedIn) {
      return MaterialApp(
        home: Dashboard(), 
      );
    } else {
      return MaterialApp(
        home: Login(), 
      );
    }
  }
}