import 'package:flutter/material.dart';

import '../services/storage.dart';
import 'login.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Storage _storage = Storage();

  _logout() {
    _storage.deleteAllSecureData().then((_) => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Conta"),
          ElevatedButton(onPressed: _logout(), child: const Text("Logout"))
        ],
      ),
    );
  }
}
