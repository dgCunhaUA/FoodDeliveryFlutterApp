import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_state.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/rider/profile/rider_profile_bloc.dart';
import 'package:flutter_project/rider/profile/rider_profile_state.dart';

import '../../session_cubit.dart';

class RiderProfileScreen extends StatelessWidget {
  const RiderProfileScreen({super.key});

  void _editProfile() {}

  void _checkDeliveryHistory() {}

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();

    return BlocProvider(
      create: (context) => RiderProfileBloc(rider: sessionCubit.currentRider),
      child: BlocBuilder<RiderProfileBloc, RiderProfileState>(
        builder: (context, state) {
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
                        state.rider.name,
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        state.rider.address,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ElevatedButton(
                          onPressed: _checkDeliveryHistory,
                          child: const Text("Historico de entregas")),
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
