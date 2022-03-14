import 'package:flutter/material.dart';
import 'package:lonelydubai/Screens/LoginScreen.dart';
import 'package:lonelydubai/Screens/MainTabScreen.dart';
import 'package:lonelydubai/Themes/AppTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lonely Dubai',
      theme: AppTheme.getLightTheme(context),
      darkTheme: AppTheme.getDarkTheme(context),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

