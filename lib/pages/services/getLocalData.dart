import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getUserDataFromLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataJson = prefs.getString('userData');

if (userDataJson != null) {
    Map<String, dynamic> userData = json.decode(userDataJson);
    return userData;
  } else { 
    return {};
  }
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userToken = prefs.getString('token');

if (userToken != null) {
    String token =userToken;
    return token;
  } else { 
    return "";
  }
}