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
<<<<<<< HEAD
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
=======
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(isLoggedInProvider);
    print('loggedIn: $loggedIn');

    if (loggedIn) {
      return MaterialApp(
        home: Dashboard(),
      );
    } else {
      return MaterialApp(
        home: Dashboard(),
      );
    }
>>>>>>> e47129d9621b0e5b0a17f8e450e32b15679678b5
  }
}
