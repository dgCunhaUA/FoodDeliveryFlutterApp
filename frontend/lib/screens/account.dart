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
  } //ElevatedButton(onPressed: _logout(), child: const Text("Logout"))

  _editProfile() {
    // TODO:
  }

  _checkOrdersHistory() {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.75,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[300],
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage("images/me.jpeg"),
                      fit: BoxFit.contain,
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
                const Text(
                  "Nome",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: _editProfile, child: const Text("Editar Perfil"))
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Address:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "address 1",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                    onPressed: _checkOrdersHistory,
                    child: const Text("Historico de pedidos")),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
