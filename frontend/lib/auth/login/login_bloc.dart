import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/auth/login/login_event.dart';
import 'package:flutter_project/auth/form_submission_status.dart';
import 'package:flutter_project/auth/login/login_state.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../models/Rider.dart';
import '../../models/Client.dart';
import '../auth_credentials.dart';
import '../auth_cubit.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.userRepo, required this.authCubit})
      : super(LoginState()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is LoginEmailChanged) {
          _handleLoginEmailChanged(event, emit);
        } else if (event is LoginPasswordChanged) {
          _handleLoginPasswordChanged(event, emit);
        } else if (event is LoginSubmitted) {
          await _handleLoginSubmitted(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  void _handleLoginEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _handleLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      Client client = await userRepo.login(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.launchSession(AuthCredentials(
        email: state.email,
        userId: client.id,
      ));
    } on Exception catch (e) {
      print(e);
      //emit(state.copyWith(formStatus: SubmissionFailed(e)));
    }

    try {
      Rider rider = await userRepo.loginRider(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.launchSession(AuthCredentials(
        email: state.email,
        riderId: rider.id,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e)));
    }
  }
}
