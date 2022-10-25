// Created by: Simão Bentes, 97761

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_project/widgets/tabbar_menu.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodDelivery',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
          )),
      home: const LoginScreen(),
    );
  }
}
