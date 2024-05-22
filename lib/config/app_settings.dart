
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {

  readUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final password = prefs.getString('password') ?? '';
    final userId = prefs.getInt('userId') ?? 0;
    final isChecked = prefs.getBool('isChecked') ?? false;
    var userData = {
      'username': username,
      'password': password,
      'userId': userId,
      'isChecked': isChecked,
    };
    return userData;
  }

  setUserData(String username, String password, int userId, bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setInt('userId', userId);
    await prefs.setBool('isChecked', isChecked);
  }

  deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', '');
    await prefs.setString('password', '');
    await prefs.setInt('userId', 0);
    await prefs.setBool('isChecked', false);
  }

}
