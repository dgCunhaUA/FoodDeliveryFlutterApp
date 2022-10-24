import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/session_state.dart';

import '../models/User.dart';
import '../services/storage.dart';
import '../session_cubit.dart';
import 'login_old.dart';
import 'login.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  void init() {}

  void _editProfile() {}

  void _checkOrdersHistory() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      //final state = BlocProvider.of<UsersOwnProfileBloc>(context).state;
      if (state is Authenticated) {
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.75,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
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
                    Text(
                      state.user.firstName,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: _editProfile,
                        child: const Text("Editar Perfil"))
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Addresses:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      state.user.address,
                      style: const TextStyle(fontSize: 15),
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
                    onPressed: () =>
                        BlocProvider.of<SessionCubit>(context).signOut(),
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
      } else {
        return const Text("");
      }
    });

    /*Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.75,
          width: MediaQuery.of(context).size.width,
          color: Colors.black12,
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
                "Addresses:",
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
                onPressed: () =>
                    BlocProvider.of<SessionCubit>(context).signOut(),
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
    ); */
  }
}
