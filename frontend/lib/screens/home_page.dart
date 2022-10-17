import 'package:flutter/material.dart';
import 'package:flutter_project/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/storage.dart';
import '../widgets/tabbar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Storage _storage = Storage();
  String _token = "";

  @override
  initState() {
    super.initState();

    _storage.getToken().then((token) => {
          if (token != null)
            {
              setState(() {
                _token = token;
              }),
            }
          else
            {
              print("....."),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Text("FoodDelivery"), Text(_token)],
      ),
    );
  }
}
