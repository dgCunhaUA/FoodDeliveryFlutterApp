import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_cubit.dart';
import 'auth_credentials.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);

  void launchSession(AuthCredentials credentials) => {
        if (credentials.riderId != null)
          sessionCubit.showRiderSession(credentials)
        else
          sessionCubit.showClientSession(credentials)
      };
}
