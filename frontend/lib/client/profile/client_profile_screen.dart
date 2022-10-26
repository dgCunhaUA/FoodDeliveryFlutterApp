import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_event.dart';
import 'package:flutter_project/client/profile/client_profile_state.dart';
import 'package:flutter_project/utils/api.dart';

import '../../session_cubit.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  void _editProfile() {}

  void _checkOrdersHistory() {}

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();

    return BlocProvider(
      create: (context) =>
          ClientProfileBloc(client: sessionCubit.currentClient),
      child: BlocBuilder<ClientProfileBloc, ClientProfileState>(
        builder: (context, state) {
          //var image = _getImg();

          print(state.client!.photo);

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
                          child: state.isEditing
                              ? const Text("Editing")
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: state.client!.photo != null
                                      ? Image.network(
                                          "$urlAPI/client/photos/${state.client!.photo!}")
                                      : const Image(
                                          image: AssetImage("images/me.jpeg"),
                                          fit: BoxFit.contain,
                                          width: 130,
                                          height: 130,
                                        ),
                                )),
                      Text(
                        state.client!.name,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      state.isEditing
                          ? TextButton(
                              onPressed: () => context
                                  .read<ClientProfileBloc>()
                                  .add(SaveProfileRequest()),
                              child: const Text("Guardar Alterações"),
                            )
                          : TextButton(
                              onPressed: () => context
                                  .read<ClientProfileBloc>()
                                  .add(EditProfileRequest()),
                              child: const Text("Editar Perfil"),
                            )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Addresses:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        state.client!.address,
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
        },
      ),
    );
  }
}
