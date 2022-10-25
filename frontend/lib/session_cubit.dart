import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/models/Rider.dart';
import 'package:flutter_project/repositories/user_repository.dart';

import 'auth/auth_credentials.dart';
import 'models/Client.dart';
import 'models/User.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final UserRepository userRepo;

  SessionCubit({required this.userRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  Client get currentClient => (state as ClientAuthenticated).client;
  Rider get currentRider => (state as RiderAuthenticated).rider;

  void attemptAutoLogin() async {
    try {
      Client? client = await userRepo.getClient();
      emit(ClientAuthenticated(client: client!));
      return;
    } on Exception {}
    try {
      Rider? rider = await userRepo.getRider();
      emit(RiderAuthenticated(rider: rider!));
      return;
    } on Exception {}
    emit(Unauthenticated());
  }

  void showAuth() => emit(Unauthenticated());
  void showClientSession(AuthCredentials credentials) async {
    Client? client = await userRepo.getClient();
    emit(ClientAuthenticated(client: client!));
  }

  void showRiderSession(AuthCredentials credentials) async {
    Rider? rider = await userRepo.getRider();
    emit(RiderAuthenticated(rider: rider!));
  }

  void signOut() {
    userRepo.signOut();
    emit(Unauthenticated());
  }
}
