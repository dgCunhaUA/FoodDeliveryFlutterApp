import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/repositories/user_repository.dart';

import 'auth/auth_credentials.dart';
import 'models/User.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final UserRepository userRepo;

  SessionCubit({required this.userRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      User? user = await userRepo.getUser();
      emit(Authenticated(user: user!));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) async {
    User? user = await userRepo.getUser();
    emit(Authenticated(user: user!));
  }

  void signOut() {
    userRepo.signOut();
    emit(Unauthenticated());
  }
}
