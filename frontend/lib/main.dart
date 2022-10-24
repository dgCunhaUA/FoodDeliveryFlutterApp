// Created by: Simão Bentes, 97761

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/login_view.dart';
import 'package:flutter_project/repositories/user_repository.dart';

/* void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodDelivery',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
      home: const LoginScreen(),
    );
  }
} */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: LoginView(),
      ),
    );
  }
}
