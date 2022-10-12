// Created by: Simão Bentes, 97761

import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/tabbar_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAudio',
      theme: ThemeData(
        useMaterial3: true,
        splashColor: Colors.black54,
        primarySwatch: Colors.indigo,
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 30, 30, 30),
            surfaceTintColor: Color.fromARGB(255, 30, 30, 30),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 30, 30, 30),
          unselectedItemColor: Colors.white,
        ),
      ),
      home: const TabBarMenu(),
    );
  }
}
