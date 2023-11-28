import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

////
  static Future<bool> isFirstUser() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('is_new_user') ?? true;
  }

  void setOldUser() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('is_new_user', false);
  }
}
