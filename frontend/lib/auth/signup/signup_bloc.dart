import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/User.dart';
import '../../repositories/user_repository.dart';
import '../auth_credentials.dart';
import '../auth_cubit.dart';
import '../form_submission_status.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.userRepo, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpEvent>(
      (event, emit) async {
        if (event is SignUpEmailChanged) {
          _handleSignUpEmailChanged(event, emit);
        } else if (event is SignUpPasswordChanged) {
          _handleSignUpPasswordChanged(event, emit);
        } else if (event is SignUpUsernameChanged) {
          _handleSignUpUsernameChanged(event, emit);
        } else if (event is SignUpAddressChanged) {
          _handleSignUpAddressChanged(event, emit);
        } else if (event is SignUpVehicleChanged) {
          _handleSignUpVehicleChanged(event, emit);
        } else if (event is SignUpSubmitted) {
          await _handleSignUpSubmitted(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  void _handleSignUpUsernameChanged(
      SignUpUsernameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _handleSignUpEmailChanged(
      SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _handleSignUpPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _handleSignUpAddressChanged(
      SignUpAddressChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(address: event.address));
  }

  void _handleSignUpVehicleChanged(
      SignUpVehicleChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(vehicle: event.vehicle));
  }

  Future<void> _handleSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      User user = await userRepo.signUp(
        username: state.username,
        email: state.email,
        password: state.password,
        address: state.address,
      );

      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.launchSession(AuthCredentials(
        username: state.username,
        email: state.email,
        userId: user.id,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e)));
    }
  }
}
