import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login_old.dart';
import '../services/storage.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [const Text("FoodDelivery")],
      ),
    );
  }
}
