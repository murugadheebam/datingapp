import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


// final userProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
// final isLoggedInProvider = StateProvider<bool>((ref) => false);


final userProvider = StateProvider<Map<String, dynamic>?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final userDataString = prefs.getString('userData');
  return userDataString != null ? json.decode(userDataString) : null;
});

final isLoggedInProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool('isLoggedIn') ?? false;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); 
});